<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>登录</title>
    <style>
      #loginBox{
        width:400px;
        background:#ccffcc ;
        border : 2px solid #ccc ;
        border-radius:10px;
        margin:100px auto ;

        padding-bottom: 10px;
      }

      #loginBox input{
        width:250px;
        height:30px;
        padding-left:4px
      }

      #loginBox tr{
        height:40px ;
      }

      #loginBox button{
        width:60px;
        height:40px;
      }
      #msg{
        color: red ;
        text-align:center ;
        font-size:14px ;
        height:14px;
      }
    </style>
  </head>
  <body>
    <div id="loginBox">
      <h2 align="center">用户登录</h2>
      <div id="msg">
        ${flag=='9'?'用户名密码错误':''}
      </div>
      <form action="login.do" method="post">
        <table align="center">
          <tr>
            <td>用户名：</td>
            <td><input name="uname" required="required" /></td>
          </tr>
          <tr>
            <td>密码：</td>
            <td><input type="password" name="upass" required="required" /></td>
          </tr>
          <tr>
            <td colspan="2" align="center"><button>登录</button></td>
          </tr>
        </table>
      </form>
    </div>
  </body>
</html>
