<%@ page pageEncoding="utf-8" %>
<!doctype html>
<html>
    <head>
        <style>
            #box{
               width:600px;
                margin:0 auto;
            }

            #box ul{
                float:left;
                padding:0;
                margin:0;
            }
            #box li {
                margin:0;
                padding:0;
            }
            #noList{
                width:260px;
                height:300px;
                border:2px solid #cccccc ;
                padding:0;
            }
            #noList li{
                list-style:none;
                margin:0;
                border-bottom:1px dotted #cccccc;
                line-height: 24px;
                padding:4px;
                cursor:pointer;
            }

            #btns{
                width:50px;
            }
            #btns button{
                width:40px;
                height:30px;
                margin:0 5px;
                margin-top:80px;
            }


            #yesList{
                width:260px;
                height:300px;
                border:2px solid #cccccc ;
                padding:0;
            }
            #yesList li{
                list-style:none;
                margin:0;
                border-bottom:1px dotted #cccccc;
                line-height: 24px;
                padding:4px;
                cursor:pointer;
            }
        </style>
        <script src="js/jquery-3.5.1.min.js"></script>
        <script>
            $(function(){
                //查询组装当前用户未分配的角色
                $.post('noList.do', {'uno':$('#uno').val()} ,function(roles){
                    for(var i=0;i<roles.length;i++){
                        var role = roles[i];
                        $('#noList').append('<li rno="'+role.rno+'">'+role.rname+'</li>')
                    }

                    //为左侧列表增加双击向右移动功能
                    addDblclickToRight();

                } ,'json');

                //查询组装已分配的角色
                $.ajax( {
                    url:'yesList.do',
                    data:{'uno':$('#uno').val()},
                    dataType:'json',
                    success:function(roles){
                        for(var i=0;i<roles.length;i++){
                            var role = roles[i] ;
                            $('#yesList').append('<li rno="'+role.rno+'">'+role.rname+'</li>');
                        }
                        //为右侧列表项增加双击向左移动操作
                        addDblclickToLeft();
                    },

                    type:'post',
                    error:function(){
                        alert('error');
                    }
                } );


                //增加全左，全右按钮事件
                $('#rightBtn').click(function(){
                    $('#noList').children().appendTo( $('#yesList') );
                    addDblclickToLeft();
                });

                $('#leftBtn').click(function(){
                    $('#yesList').children().appendTo( $('#noList') );
                    addDblclickToRight();
                });


                //保存
                $('#saveBtn').click(function(){
                    var uno = $('#uno').val();
                    var rnos = '' ;
                    $('#yesList li').each(function(i,e){
                        rnos += $(e).attr('rno')+',' ;
                    });

                    $.post('setRoles.do',{'uno':uno,'rnos':rnos},function(){
                        alert('保存完毕');
                    });

                });

            });

            function addDblclickToRight(){
                $('#noList li').off('dblclick').dblclick(function(){
                    $(this).appendTo( $('#yesList') );

                    //$('#yesList').append($(this)) ;
                    addDblclickToLeft();
                });
            }

            function addDblclickToLeft(){
                $('#yesList li').off('dblclick').dblclick(function(){
                    $(this).appendTo( $('#noList') );

                    //$('#yesList').append($(this)) ;
                    addDblclickToRight();
                });
            }
        </script>
    </head>
    <body>
        <input type="hidden" id="uno" value="${param.uno}" />
        <h2 align="center">为用户【${param.truename}】分配角色</h2>
        <p align="center">
            <button type="button" id="saveBtn">保存</button>
        </p>
        <div id="box">
            <ul id="noList">
               <%--
                <li>系统管理员</li>
                <li>普通管理员</li>--%>
            </ul>
            <ul id="btns">
                <button id="rightBtn" type="button"> &gt;&gt; </button>
                <button id="leftBtn" type="button"> &lt;&lt; </button>
            </ul>
            <ul id="yesList">
                <%--<li>库管员</li>--%>
            </ul>
        </div>
    </body>
</html>