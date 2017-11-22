<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="jspbooks.addrbook.*,java.util.*"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="ab" scope="page" class="jspbooks.addrbook.AddrBean"/>
<jsp:useBean id="addrbook" class="jspbooks.addrbook.AddrBook"/>
<jsp:setProperty name="addrbook" property="*" />
<% 

   String action = request.getParameter("action");

   if(action == null) action="list";
   if(action.equals("list")) {
      ArrayList<AddrBook> datas = ab.getDBList();
      request.setAttribute("datas", datas);
      pageContext.forward("addrbook_list.jsp");
   }
   else if(action.equals("insert")) {      
      if(ab.insertDB(addrbook)) {
         response.sendRedirect("addrbook_control.jsp?action=list");
      }
      else
         throw new Exception("DB 입력오류");
   }

   else if(action.equals("edit")) {
      AddrBook abook = ab.getDB(addrbook.getAb_id());
      if(!request.getParameter("upasswd").equals("1234")) {
         out.println("<script>alert('비밀번호가 틀렸습니다.!!');history.go(-1);</script>");
      }
      else {
         request.setAttribute("ab",abook);
         pageContext.forward("addrbook_edit_form.jsp");
      }
   }
   else if(action.equals("update")) {
         if(ab.updateDB(addrbook)) {
            response.sendRedirect("addrbook_control.jsp?action=list");
         }
         else
            throw new Exception("DB 갱신오류");
   }

   else if(action.equals("delete")) {
      if(ab.deleteDB(addrbook.getAb_id())) {
         response.sendRedirect("addrbook_control.jsp?action=list");
      }
      else
         throw new Exception("DB 삭제 오류");
   }
   else {
      out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
   }
%>