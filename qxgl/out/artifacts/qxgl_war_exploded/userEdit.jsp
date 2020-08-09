<%@ page pageEncoding="utf-8" %>
<!doctype html>
<html>
    <head>
        <style>
            #userEditBox{
                width:400px;
                background:#ccffcc ;
                border:2px solid #ccc ;
                margin:20px auto ;

                padding-bottom:10px;
            }

            #userEditBox input{
                width:250px;
                height:25px;
                padding-left:4px;
            }
            #userEditBox button{
                width:60px;
                height:30px
            }
            #userEditBox li{
                margin-top:4px;
            }
        </style>
    </head>
    <body>
        <div id="userEditBox">
            <h2 align="center">用户修改</h2>
            <form id="userEditForm" action="userUpdate.do" method="post">
                <input name="uno" type="hidden" value="${user.uno}" />
                <ul>
                    <li>用户名称：<input name="uname" required="required" value="${user.uname}" /></li>
                    <li>真实姓名：<input name="truename" required="required" value="${user.truename}" /></li>
                    <li>用户年龄：<input type="number" name="age" required="required" value="${user.age}" /></li>
                    <li>用户性别：<input name="sex" required="required" list="sexList" value="${user.sex}" />
                        <datalist id="sexList">
                            <option>男</option>
                            <option>女</option>
                        </datalist>
                    </li>
                    <li>电话号码：<input name="phone" required="required" value="${user.phone}" /></li>
                    <li><button>保存</button></li>
                </ul>
            </form>
        </div>
    </body>
</html>