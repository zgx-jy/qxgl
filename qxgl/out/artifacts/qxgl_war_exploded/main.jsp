<%@ page pageEncoding="utf-8" %>
<!doctype html>
<html>
    <head>
        <title>主页面</title>
        <script src="js/jquery-3.5.1.min.js"></script>
        <style>
            body,html{
                width:100%;
                height:100%;
            }
            #top{
                height:15% ;
                border-bottom:2px solid #ccc;
            }
            #left{
                width:20% ;
                height:85% ;
                border-right:2px solid #ccc ;
                float:left;
            }
            #right{
                width:79% ;
                height:85% ;
                float:right ;
            }
            #loginMsg{
                position:relative ;
                top:50px ;
                left:100px;
            }
            #left li{
                list-style:none;
            }
            #left span{
                cursor: pointer;
            }
        </style>
        <script>
            $(function(){
                $.post('userMenus.do',{},function(menus){
                    //显示菜单

                    function showPreLevelMenu(pno,$position){
                        var ul = null ;
                        for(var i=0;i<menus.length;i++){
                            var menu = menus[i];
                            if(menu.pno ==pno){
                                if(ul == null){
                                    ul = $('<ul>') ;
                                    $position.append(ul) ;
                                }
                                var li = $('<li>') ;
                                ul.append(li);
                                if(menu.mhref){
                                    //当前菜单需要发送请求
                                    li.append('<span><a href="'+menu.mhref+'" target="'+menu.mtarget+'">'+menu.mname+'</a></span>');
                                }else{
                                    li.append('<span>'+menu.mname+'</span>');
                                }


                                showPreLevelMenu(menu.mno,li);
                            }
                        }
                    }

                    showPreLevelMenu(-1, $('#left') );// 从根菜单显示

                },'json');
            });
        </script>
    </head>
    <body>
        <div id="top">
           <span id="loginMsg">欢迎【${sessionScope.loginUser.truename}】登录</span>
        </div>
        <div id="left">
            <!--
            <ul id="menuBox">
                <li>
                    <span>权限管理</span>
                    <ul>
                        <li><span><a href="userList.do" target="right">用户管理</a></span></li>
                        <li><span><a href="roleList.do" target="right">角色管理</a></span></li>
                        <li><span><a href="menuList.jsp" target="right">菜单管理</a></span></li>
                    </ul>
                </li>
                <li>
                    <span>基本信息管理</span>
                    <ul>
                        <li><span>商品管理</span></li>
                        <li><span>供应商管理</span></li>
                        <li><span>库房管理</span></li>
                    </ul>
                </li>
                <li>
                    <span>系统管理</span>
                    <ul>
                        <li><span>修改密码</span></li>
                        <li><span>注销</span></li>
                    </ul>
                </li>
            </ul>
            -->
        </div>
        <div id="right">
            <iframe name="right" width="100%" height="100%" frameborder="0" />
        </div>
    </body>
</html>