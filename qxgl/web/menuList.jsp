<%@ page pageEncoding="utf-8" %>
<!doctype html>
<html>
    <head>
        <script src="js/jquery-3.5.1.min.js" ></script>
        <style>
            ul,li{
                list-style:none;
            }
            li{
                margin-top:4px;
                margin-bottom:4px;
            }
            ul span{
                cursor:pointer;
            }
            #mname,#mhref,#mtarget,#pno{
                width:100px ;
                margin-right:8px;
            }
            #active{
                background:#008c8c ;
            }
            ul a{
                padding:7px;
            }
            ul a.open{
                background:url(images/open.png) no-repeat 0 10px;
                margin-right:4px;
            }
            ul a.close{
                background:url(images/close.png) no-repeat 0 10px;
                margin-right:4px;
            }
        </style>
        <script>
            //window.onload = function(){}
            $(function(){
                //ajax请求所有的菜单信息
                $.post(
                    'menuList.do',                  //url
                    {uname:'dmc',upass:'123'},      //参数
                    function(data){
                                                    //回调函数
                        //将data中装载的菜单信息显示在页面上
                        //data中的菜单信息是独立存放的
                        //但我们希望可以按照子父关系显示
                        //我们就需要一层一层的显示
                        //如果要将第一层菜单显示完整
                        //就必须先将第二层菜单显示完整。
                            //* 第一层菜单不仅包括自己的信息，还包括子菜单信息
                        //如果要将第二层菜单显示完整，就必须先将第三层显示完整
                        //无论显示哪一层菜单，显示机制都是一样
                        //之就需要递归

                        //在指定的位置显示某一层的子菜单
                        function showLevelMenu(pno,$position){
                            var ul = $('<ul>') ; //新建ul
                            $position.append(ul) ; // 将ul装入指定的父级标签
                            //在所有的菜单中找到当前这层的子菜单
                            for(var i=0;i<data.length;i++){
                                var menu = data[i] ;
                                if(menu.pno == pno){
                                    //找到了一个当前层子菜单，显示
                                    var li = $('<li>') ;
                                    ul.append(li) ;

                                    var span = $('<span mno="'+menu.mno+'"><input type="hidden" value="'+menu.mno+'" />'+menu.mname+'</span>') ;
                                    li.append(span) ;
                                    //当前菜单自己的信息显示完毕，还需要显示其子集菜单
                                    showLevelMenu(menu.mno,li);
                                }
                            }

                        }

                        showLevelMenu(-1,$('body'));// 在body中显示-1层的子菜单，第一层菜单

                        //扩展：菜单展开合并
                        /*
                        $('ul span').click(function(){
                            // span   ul
                            $(this).next().toggle(1000); //1秒完成上下滑动的展开或合并
                        });
                        */


                        //为菜单增加点击事件，实现点击选择
                        $('ul span').click(function(){
                            $('#active').attr('id','');//取消之前的选中状态
                            $(this).attr('id','active') ;//增加当前的选中状态
                        });

                        //为菜单增加双击事件，实现双击修改
                        addMenuDblClick( $('ul span') ) ;

                        //为父级菜单增加展开合并的图标，并增加展开合并的点击事件
                        $('ul span').before('<a >') ;
                        $('ul a').each(function(i , e){
                            //e 表示每一个a标签对象
                            // a    li      ul
                            $ul = $(e).parent().children('ul');
                            if($ul.children().length > 0){
                                //当前菜单有子菜单，所以当前的菜单可以展开或者合并，需要有图标
                                //默认情况下菜单都是展开是展开的
                                $(e).addClass('open') ;
                            }
                        });
                        $('ul a').click(function(){
                            var flag = $(this).attr('class') ;
                            if(flag == null || flag == '' || flag=='undefined'){
                                //当前菜单没有展开合并图标，是一个叶子菜单，没有子菜单
                                return ;
                            }else if(flag == 'open'){
                                //有class属性，是一个父级菜单，正处于展开状态
                                // a    span    ul
                                $(this).next().next().toggle(1000);
                                $(this).removeClass('open');
                                $(this).addClass('close');
                            }else{
                                //处于关闭状态
                                // a    span    ul
                                $(this).next().next().toggle(1000);
                                $(this).removeClass('close');
                                $(this).addClass('open');
                            }

                        })

                    },
                    'json'
                );
            });

            function addRootMenu(){
                if($('#mname').length != 0){
                    return ;
                }
                var li = $('<li><input id="mname" placeholder="菜单名称" /><input id="mhref" placeholder="菜单请求" /><input id="mtarget" placeholder="显示位置" /><button id="saveBtn">保存</button></li>') ;
                $('ul:first').append(li);

                $('#saveBtn').click(function(){
                    //保存根菜单信息
                    saveMenu(-1);
                });
            }

            function saveMenu(pno){
                var mname = $('#mname').val();
                var mhref = $('#mhref').val();
                var mtarget = $('#mtarget').val();
                if(mname == ''){
                    alert('请输入菜单信息');
                    return ;
                }
                //发送请求，让后台程序实现保存
                //js发送请求的方式
                //location.href='url' , window.open('url') , ajax
                $.ajax({
                    url:'addMenu.do',
                    data:{'pno':pno,'mname':mname,'mhref':mhref,'mtarget':mtarget},
                    type:'post',
                    success:function(mno){
                        alert('保存成功'+mno) ;
                        //刷新菜单栏
                        // input      li
                        var li = $('#mname').parent();
                        li.empty();//删除li里面的组件
                        li.append('<span mno="'+mno+'" >'+mname+'</span>');

                        li.children().click(function(){
                            $('#active').attr('id','');//取消之前的选中状态
                            $(this).attr('id','active') ;//增加当前的选中状态
                        });

                        addMenuDblClick( li.children() );
                    },
                    error:function(){
                        alert('error')
                    }
                });
            }

            function addChildMenu(){
                var p = $('#active') ;
                if(p.length == 0){
                    alert('请选择父级菜单') ;
                    return ;
                }

                if($('#mname').length != 0){
                    return ;
                }

                //选择了父级菜单，需要为其增加输入子菜单内容的输入框
                var ul = p.next(); // ul就是用来包裹当前选中菜单的子菜单列表标签
                ul.append('<li><input id="mname" placeholder="菜单名称" /><input id="mhref" placeholder="菜单请求" /><input id="mtarget" placeholder="显示位置" /><button id="saveBtn">保存</button></li>')

                $('#saveBtn').click(function(){
                               //btn   li          ul    span
                    var pno = $(this).parent().parent().prev().attr('mno');
                    saveMenu(pno);
                });
            }

            function addMenuDblClick($menus){
                $menus.dblclick(function(){
                    //先查询修改信息的原始数据
                    if($('#mname').length != 0){
                        //现在正有一个菜单新建或修改操作
                        return ;
                    }
                    var span = $(this) ;
                    var mno = span.attr('mno') ;
                    $.post('menuOne.do',{'mno':mno},function(menu){

                        var li = span.parent();
                        span.empty();
                        var mhref ='' ;
                        if(menu.mhref){
                            mhref = menu.mhref ;
                        }
                        var mtarget = '' ;
                        if(menu.mtarget){
                            mtarget  = menu.mtarget ;
                        }
                        span.append('<input id="mno" type="hidden" value="'+menu.mno+'" />');
                        span.append('<input id="mname" value="'+menu.mname+'" />');
                        span.append('<input id="mhref" value="'+mhref+'" />');
                        span.append('<input id="mtarget" value="'+mtarget+'" />');
                        span.append('<button id="updateBtn">修改</button>');

                        $('#updateBtn').click(function(){
                            var mno = $('#mno').val();
                            var mname = $('#mname').val();
                            var mtarget=$('#mtarget').val();
                            var mhref = $('#mhref').val() ;

                            $.post(
                                'menuUpdate.do',
                                {'mno':mno,'mname':mname,'mhref':mhref,'mtarget':mtarget},
                                function(){
                                    alert('修改成功');
                                    var span = $('#mno').parent();
                                    span.empty();
                                    span.append(mname);


                                }
                            );
                        });
                    },'json');

                });
            }

            function deleteMenu(){
                var span = $('#active') ;
                if(span.length == 0){
                    //没有选择删除的菜单
                    alert('请选择要删除的菜单');
                    return ;
                }
                var f = confirm('是否确认删除') ;
                if(!f)return ;
                var mno = span.attr('mno') ;
                $.post('menuDelete.do',{'mno':mno},function(){
                    alert('删除成功') ;
                    span.parent().remove();
                });

            }
        </script>
    </head>
    <body>
        <div>
            <a href="javascript:addRootMenu()">新建根菜单</a> |
            <a href="javascript:addChildMenu()">新建子菜单</a> |
            <a href="javascript:deleteMenu()">删除菜单</a>
        </div>
       <%--<ul>
           <li>
               <span>权限管理</span>
               <ul>
                   <li>
                       <a><span><input /><input /><input /><input /></span>
                       <ul>
                           <li></li>
                           <li><span>会员用户</span></li>
                           <li><input />...</li>
                       </ul>
                   </li>
                   <li>
                       <span>角色管理</span>
                   </li>
               </ul>
           </li>
           <li>
               <span>基本信息管理</span>
               <ul>
                   <li>
                       <span>用户管理</span>
                       <ul>
                           <li><span>普通用户</span></li>
                           <li><span>会员用户</span></li>
                       </ul>
                   </li>
                   <li>
                       <span>角色管理</span>
                   </li>
               </ul>
           </li>
           <li>
               <span>系统管理</span>
               <ul>
                   <li>
                       <span>用户管理</span>
                       <ul>
                           <li><span>普通用户</span></li>
                           <li><span>会员用户</span></li>
                       </ul>
                   </li>
                   <li>
                       <span>角色管理</span>
                   </li>
               </ul>
           </li>
           <li><span>学生管理</span></li>
       </ul>--%>


    </body>
</html>