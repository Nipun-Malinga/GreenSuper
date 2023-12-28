<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
        <form action="feedback" method="post">
            <input type="text" inputmode="numeric" pattern="[0-9]*" name="billId" onkeypress="return event.charCode >= 48 && event.charCode <= 57">
            <textarea name="feedback">
            </textarea>
            <button type="submit">Submit feedback</button>
        </form>
</body>
</html>
