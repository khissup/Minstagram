<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="main-menu-bar">
          <span>
              <a href="${pageContext.request.contextPath}/index.jsp">
                  <img src="${pageContext.request.contextPath}/assets/icons/logotest5.png" class="logo-image">
              </a>
          </span>
    <span>
              <form action="${pageContext.request.contextPath}/hashPostView.jsp" method="get" onsubmit="addSharp()" name="search">
                  <input type="text" placeholder="검색" class="main-menu-search-box search-placeholder" name="hash" id="hash">
              </form>
          </span>
    <span>
        <a href="${pageContext.request.contextPath}/totalPostView.jsp">
            <img src="${pageContext.request.contextPath}/assets/icons/explore3.png">
        </a>
        
        <img src="${pageContext.request.contextPath}/assets/icons/remove.png">
        <!-- 공간확보용.. -->
        
        <a href="${pageContext.request.contextPath}/profile/profilePage.jsp?user_id=<%=session.getAttribute("memId")%>">
            <img src="${pageContext.request.contextPath}/assets/icons/profile3.png">
        </a>
        
        <img src="${pageContext.request.contextPath}/assets/icons/remove.png">
        <!-- 공간확보용.. -->
        
        <a href="${pageContext.request.contextPath}/postEdit/imageSelectPage.jsp">
            <img src="${pageContext.request.contextPath}/assets/icons/upload3.png">
        </a>
    </span>
</div>

<script>
    function addSharp(){
        var hashContent = document.getElementById("hash").value;
        document.search.hash.value= "#" + hashContent;
        document.getElementByName("search").submit();
    }
</script>
