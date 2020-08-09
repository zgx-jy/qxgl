<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
    <head>
        <script>
            window.onload = function(){
                //网页内容加载完毕时触发，js主方法

                //斑马条纹
                var tbody = document.getElementById("userBody");
                var trs = tbody.getElementsByTagName('tr') ;
                for(var i=0;i<trs.length;i++){
                    var tr = trs[i] ;
                    if(i%2 == 0){
                        tr.style.background='#ccffcc' ;
                    }else{
                        tr.style.background='#ffffff' ;
                    }
                }

                //鼠标移动时背景处理
                for(var i=0;i<trs.length;i++){
                    var tr = trs[i];
                    tr.onmouseover = function(){
                        var oldColor = this.style.background ;
                        this.style.background='#008c8c' ;
                        this.onmouseout = function(){
                            this.style.background=oldColor ;
                        }
                    }

                    //数据行增加点击勾选功能
                    tr.onclick = function(){
                        var input = this.getElementsByTagName('input')[0] ;
                        input.checked = !input.checked ;
                    }

                    //行中的复选框增加点击判断功能
                    var  input = tr.getElementsByTagName("input")[0];
                    input.onclick = function(ev){
                        //阻止冒泡
                        var e = window.event || ev ;
                        e.stopPropagation();
                    }
                }

                //设置全选
                var inputs = document.getElementsByTagName('input') ;
                //找到第一个复选框（全选）
                for(var i=0;i<inputs.length;i++){
                    var input = inputs[i] ;
                    if(input.type == 'checkbox'){
                        input.onclick = function(){
                            //将其他复选框的勾选状态 与 当前复选框勾选状态设置相同
                            var f = this.checked ;

                            for(var j=0;j<inputs.length;j++){
                                if(inputs[j].type=='checkbox'){
                                    inputs[j].checked = f;
                                }
                            }

                        }
                        break ;
                    }
                }
            }

            function userDelete(uno){
                var f = confirm('是否确认删除');
                if(!f)return ;
                location.href='userDelete.do?uno='+uno;

            }

            function userDeletes(){
                //获得选中的(要删除的)记录的编号
                var tbody = document.getElementById('userBody') ;
                var inputs = tbody.getElementsByTagName("input") ;
                var unos = '' ;
                for(var i=0;i<inputs.length;i++){
                    if( inputs[i].checked ){
                        //inputs[i].value ;
                        var uno = inputs[i].parentNode.nextElementSibling.innerHTML ;
                        unos += uno +',' ;
                    }
                }
                if(unos == ''){
                    //一个没选
                    alert('请选择要删除的记录');
                }else{
                    var f = confirm('是否确认删除');
                    if(!f)return ;
                    location.href='userDeletes.do?unos='+unos
                }
            }
        </script>
    </head>
    <body>
        <h2 align="center">用户列表</h2>
        <p align="center">
            <a href="userAdd.jsp" >新建用户</a>
            <a href="javascript:userDeletes()">批量删除</a>
            <a href="userAdds.jsp">批量导入</a>
        </p>
        <table  border="1" width="90%" align="center" cellspacing="0">
            <thead>
                <tr>
                    <th><input id="allBtn" type="checkbox" /></th>
                    <th>用户编号</th>
                    <th>用户名称</th>
                    <th>用户密码</th>
                    <th>真实姓名</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>电话号码</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="userBody">
                <c:forEach items="${requestScope.users}" var="user">
                    <tr align="center">
                         <td><input type="checkbox" value="${user.uno}" /></td>
                         <td>${user.uno}</td>
                         <td>${user.uname}</td>
                         <td>${user.upass}</td>
                         <td>${user.truename}</td>
                         <td>${user.age}</td>
                         <td>${user.sex}</td>
                         <td>${user.phone}</td>
                         <td>
                             <a href="javascript:userDelete(${user.uno})">删除</a> |
                             <a href="userEdit.do?uno=${user.uno}">编辑</a>
                             <a href="setRoles.jsp?uno=${user.uno}&truename=${user.truename}">分配角色</a>
                         </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>