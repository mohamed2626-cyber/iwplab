<%@ page import="java.util.*" %>
    <%@ page import="jakarta.servlet.http.Cookie" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <% String username=request.getParameter("username"); String feedback=request.getParameter("feedback");
                session.setAttribute("username", username); session.setAttribute("feedback", feedback); Cookie
                userCookie=new Cookie("lastUser", username); userCookie.setMaxAge(60 * 60 * 24); // 1 day
                response.addCookie(userCookie); List<String> feedbackList =
                (List<String>) application.getAttribute("feedbackList");
                    if (feedbackList == null) {
                    feedbackList = new ArrayList<String>();
                        }
                        feedbackList.add(username + ": " + feedback);
                        application.setAttribute("feedbackList", feedbackList);
                        %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Feedback Submitted</title>
                        </head>

                        <body>
                            <h2>Thank You, <%= username %>!</h2>
                            <p>Your feedback has been submitted successfully.</p>
                            <h3>Previous Feedbacks:</h3>
                            <ul>
                                <c:forEach var="item" items="${applicationScope.feedbackList}">
                                    <li>${item}</li>
                                </c:forEach>
                            </ul>
                            <% Cookie[] cookies=request.getCookies(); if (cookies !=null) { for (Cookie c : cookies) {
                                if (c.getName().equals("lastUser")) { %>
                                <p>Last visitor: <%= c.getValue() %>
                                </p>
                                <% } } } %>
                        </body>

                        </html>