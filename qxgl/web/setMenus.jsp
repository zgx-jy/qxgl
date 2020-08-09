<%@ page pageEncoding="utf-8" %>
<!doctype html>
<html>
    <head>
        <script src="js/jquery-3.5.1.min.js"></script>
        <style>
            ul,li{
                list-style:none;
                margin-top:0;
                margin-bottom:0;
                padding-top:0;
                padding-bottom:0;
            }
            li{
                margin-top:6px;
            }
            li span{
                cursor:pointer;
            }
        </style>
        <script>
            $(function(){
                //查询显示所有的菜单信息
                $.post('menuList.do',{},function(menus){
                    //按照子父关系显示

                    //显示每一层菜单
                    //pno 父级菜单编号，表示显示pno这个父级菜单的子集菜单列表
                    //$position 子集菜单列表显示的位置
                    function showPrelevelMenus(pno,$position){
                        //var ul = $('<ul>');
                        //$position.append(ul);
                        var ul = null ;

                        for(var i=0;i<menus.length;i++){
                            var menu = menus[i] ;
                            if(menu.pno == pno){
                                //找到了当前pno的一个子菜单，找到了一个当前层级的菜单
                                if(ul == null){
                                    ul = $('<ul>') ;
                                    $position.append(ul) ;
                                }
                                var li = $('<li>') ;
                                ul.append(li) ;
                                li.append('<input type="checkbox" value="'+menu.mno+'" /><span>'+menu.mname+'</span>')

                                showPrelevelMenus(menu.mno,li);
                            }
                        }

                    }

                    showPrelevelMenus(-1,$('#menuBox td'));//显示根菜单列表


                    //增加展开合并操作
                    $('#menuBox span').click(function(){
                        $(this).next().toggle(1000);
                    });


                    //全选
                    /*
                        选中父级，自动选中子级
                        选掉父级，自动选掉子级
                        选中子级，自动选中父级
                        选掉子级，自动选掉父级
                     */

                    $('#menuBox input:checkbox').click(function(){
                        var flag = $(this).prop('checked') ;
                        if(flag){
                            //选中
                            //选中子级
                            function okChildren($p){
                                            //  span    ul     li           input
                                var inputs = $p.next().next().children().children('input') ;
                                if(inputs.length == 0)
                                    return ;
                                inputs.prop('checked',flag) ;
                                okChildren(inputs) ;

                            }
                            okChildren($(this));//选中当前菜单的子级


                            //选中父级
                            function okParent($p){
                                            //  li      ul      span    input
                                var input = $p.parent().parent().prev().prev();
                                if(input.length == 0){
                                    return ;
                                }
                                input.prop('checked',flag) ;
                                okParent(input) ;
                            }
                            okParent($(this));//选中当前菜单的父级

                        }else{
                            //选掉
                            //选掉子菜单
                            function cancelChildren($p){
                                             // span    ul      lis          input
                                var inputs = $p.next().next().children().children('input');
                                if(inputs.length == 0)
                                    return ;
                                inputs.prop('checked',flag) ;
                                cancelChildren(inputs) ;

                            }
                            cancelChildren($(this)); //选掉当前菜单的子菜单

                            //选掉父菜单
                            function cancelParent($p){
                                            //   li        ul    span   input
                                var input = $p.parent().parent().prev().prev();
                                if(input.length == 0){
                                    return ;
                                }
                                               //  span   ul        lis
                                var inputs = input.next().next().children().children('input:checked');
                                if(inputs.length > 0){
                                    return ;
                                }
                                input.prop('checked',flag) ;
                                cancelParent(input) ;
                            }
                            cancelParent($(this)); //选掉当前菜单的父菜单
                        }
                    });

                    //--------------------------------
                    //查询并默认勾选之前分配的菜单
                    $.post('yesMenus.do',{'rno':$('#rno').val() } , function(mnos){
                        for(var i=0;i<mnos.length;i++){
                            var mno = mnos[i] ;
                            $('input[value="'+mno+'"]').prop('checked',true) ;
                        }
                    },'json');



                },'json');

                //--------------------------------------------------------------

                //增加保存按钮功能
                $('#saveBtn').click(function(){
                    var rno = $('#rno').val();
                    var mnos = '' ;//准备拼装所有选中的菜单编号，组成一个字符串，使用逗号隔开。
                    $('#menuBox input:checked').each(function(i,e){
                        var mno = $(e).val();
                        mnos += mno+',' ;
                    });

                    $.post('setMenus.do',{'rno':rno,'mnos':mnos},function(){
                        alert('保存成功') ;
                    });
                });



            });
        </script>
    </head>
    <body>
        <input type="hidden" id="rno" value="${param.rno}" />
        <h2 align="center">为【${param.rname}】分配菜单</h2>
        <p align="center"><button id="saveBtn" >保存</button></p>
        <table id="menuBox" align="center">
            <tr>
                <td>

                </td>
            </tr>
        </table>
    </body>
</html>