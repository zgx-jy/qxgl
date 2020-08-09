<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
    <head>
        <style>
            #searchBtns input{
                width:100px;
            }
        </style>
        <script>
            window.onload = function(){
                var rows = document.getElementById('rows') ;
                rows.onchange = function(){
                    roleList();
                }

                //为3个搜索框增加"回车事件"
                var searchBtns = document.getElementById('searchBtns') ;
                var inputs = searchBtns.getElementsByTagName('input') ;
                for(var i=0;i<inputs.length;i++){
                    inputs[i].onkeydown=function(ev){
                        var e = window.event || ev ;
                        if(e.keyCode == 13){
                            //按回车
                            roleList();
                        }
                    }
                }

                //清空查询
                var clearBtn = document.getElementById('clearBtn') ;
                clearBtn.onclick = function(){
                    var rno = document.getElementById('rno').value ='';
                    var rname = document.getElementById('rname').value ='';
                    var description = document.getElementById('description').value='' ;
                    roleList();
                }
            }

            function roleList(){
                var rows = document.getElementById('rows').value ;
                var page = document.getElementById('page').value ;
                var rno = document.getElementById('rno').value ;
                var rname = document.getElementById('rname').value ;
                var description = document.getElementById('description').value ;

                location.href='roleList.do?rows='+rows+'&page='+page+'&rno='+rno+'&rname='+rname+'&description='+description ;

            }

            function findByPage(page){
                document.getElementById('page').value = page ;
                roleList();
            }
        </script>
    </head>
    <body>
        <h2 align="center">角色列表</h2>
        <table id="searchBtns" align="center" width="80%">
            <tr>
                <td>
                    <input id="rno" placeholder="角色编号" value="${rno}"/>
                    <input id="rname" placeholder="角色名称" value="${rname}" />
                    <input id="description" placeholder="角色描述" value="${description}" />
                    <button id="clearBtn">清空查询</button>
                </td>
            </tr>
        </table>
        <table align="center" width="80%" border="1" cellpadding="0">
            <thead>
                <tr>
                    <th>角色编号</th>
                    <th>角色编号</th>
                    <th>角色名称</th>
                    <th>角色操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${roles}" var="role">
                    <tr align="center">
                        <td>${role.rno}</td>
                        <td>${role.rname}</td>
                        <td>${role.description}</td>
                        <td>
                            <a href="">删除</a> |
                            <a href="">编辑</a> |
                            <a href="setMenus.jsp?rno=${role.rno}&rname=${role.rname}">分配菜单</a>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <table align="center" width="80%">
            <tr>
                <td align="left">
                    <select id="rows">
                        <option>3</option>
                        <option>5</option>
                        <option>10</option>
                        <option selected="selected">${rows}</option>
                    </select>
                    <input type="hidden" id="page" value="${page}" />
                    第${page}页/共${maxPage}页
                </td>
                <td align="right">
                    <a href="javascript:findByPage(1)">首页</a> |
                    <c:if test="${page > 1}">
                        <a href="javascript:findByPage(${page-1})">上一页</a> |
                    </c:if>
                    <c:if test="${page < maxPage}">
                        <a href="javascript:findByPage(${page+1})">下一页</a> |
                    </c:if>
                    <a href="javascript:findByPage(${maxPage})">末页</a>
                </td>
            </tr>
        </table>
    </body>
</html>