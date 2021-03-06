<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Todo List</title>
    <link rel="stylesheet" href="<c:url value='/webjars/bootstrap/3.3.6/css/bootstrap.css'/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>" type="text/css"/>
    <spring:theme var="themeStyleSheet" code="styleSheet"/>
    <link rel="stylesheet" href="<c:url value='${themeStyleSheet}'/>" type="text/css"/>
</head>
<body>

<div class="container">

    <h1>Todo List</h1>

    <div id="todoForm">
        <c:url value="/todos" var="todosUrl"/>
        <form:form action="${todosUrl}" modelAttribute="todoForm" cssClass="form-inline">
            <form:input path="todoTitle" cssClass="form-control"/>
            <form:errors path="todoTitle" cssClass="text-error"/>
            <form:button class="btn btn-default">Create</form:button>
        </form:form>
    </div>

    <c:if test="${not empty todos}">

        <table id="todoList" class="table table-hover">
            <tr>
                <th>#</th>
                <th>Title</th>
                <th>Operations</th>
            </tr>

            <c:forEach items="${todos}" var="todo" varStatus="rowStatus">
                <tr>
                    <td>
                        <c:out value="${rowStatus.count}"/>
                    </td>
                    <td>
                        <span class="${todo.finished ? 'strike' : ''}">
                            <a href="<c:url value='/todos/${todo.todoId}'/>"><c:out
                                    value="${todo.todoTitle}"/></a>
                        </span>
                    </td>
                    <td>
                        <c:if test="${not todo.finished}">
                            <form:form action="${todosUrl}/${todo.todoId}" cssStyle="display: inline-block;">
                                <button name="finish" class="btn btn-default">Finish</button>
                            </form:form>
                        </c:if>
                        <form:form action="${todosUrl}/${todo.todoId}" cssStyle="display: inline-block;">
                            <button name="delete" class="btn btn-default">Delete</button>
                        </form:form>
                    </td>
                </tr>
            </c:forEach>

        </table>

    </c:if>

    <hr/>

    <a href="<c:url value='/'/>" class="btn btn-default">Home</a>
    <sec:authorize access="isAuthenticated()" var="isAuthenticated"/>
    <c:choose>
        <c:when test="${isAuthenticated}">
            <c:url value="/logout" var="logoutUrl"/>
            <form:form action="${logoutUrl}" cssStyle="display: inline-block;">
                <button class="btn btn-default">Logout</button>
            </form:form>
        </c:when>
        <c:otherwise>
            <a href="<c:url value='/login'/>" class="btn btn-default">Login</a>
        </c:otherwise>
    </c:choose>

</div>
</body>
</html>