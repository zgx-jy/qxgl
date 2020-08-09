<%@ page pageEncoding="utf-8" %>
<!doctype html>
<html>
    <head>
        <style>
            #userAddBox{
                width:400px;
                background:#ccffcc ;
                border:2px solid #ccc ;
                margin:20px auto ;

                padding-bottom:10px;
            }

            #userAddBox input{
                width:250px;
                height:25px;
                padding-left:4px;
            }
            #userAddBox button{
                width:60px;
                height:30px
            }
            #userAddBox li{
                margin-top:4px;
            }
        </style>
        <script>
            window.onload = function(){
                //js为form增加提交事件
                var form = document.getElementById("userAddForm") ;
                form.onsubmit = function(){
                    var upass = document.getElementById('upass') ;
                    var repass = document.getElementById('repass') ;
                    if(upass.value == repass.value){
                        return true ;
                    }else{
                        alert('两次密码不一致');
                        return false ;
                    }
                }
            }
        </script>
    </head>
    <body>
        <div id="userAddBox">
            <h2 align="center">用户新建</h2>
            <form id="userAddForm" action="userAdd.do" method="post">
                <ul>
                    <li>用户名称：<input name="uname" required="required" /></li>
                    <li>用户密码：<input type="password" id="upass" name="upass" required="required" /></li>
                    <li>确认密码：<input type="password" id="repass" required="required" /></li>
                    <li>真实姓名：<input name="truename" required="required" /></li>
                    <li>用户年龄：<input type="number" name="age" required="required" /></li>
                    <li>用户性别：<input name="sex" required="required" list="sexList" />
                                <datalist id="sexList">
                                    <option>男</option>
                                    <option>女</option>
                                </datalist>
                    </li>
                    <li>电话号码：<input name="phone" required="required" /></li>
                    <li><button>保存</button></li>
                </ul>
            </form>
        </div>
    </body>
</html>