<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>LW2-Web</title>
    <link rel="stylesheet" type="text/css" href="reset.css">
    <link rel="stylesheet" type="text/css" href="main.css">
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
</head>
<body>
<header>
    <h1>Проверка попадания точки в график</h1>
    Салимзянов Юнир Ульфатович <span>P3211</span>
    <br>Вариант - <span>352</span>
</header>
<div id="content">
    <div class="container">
        <h3>Интерактивный график:</h3>
        <canvas id="plot" width="300" height="300">
        </canvas>
        <br>Добро пожаловать в мир ВТ!
        <form action="controller" method="post" target="graphics">
            <h3>1 шаг - Выберите X координату:</h3>
            <table>
                <tr>
                    <td><input type="checkbox" name="x44" value="-4">-4</td>
                    <td><input type="checkbox" name="x11" value="-1">-1</td>
                    <td><input type="checkbox" name="x2" value="2"> 2</td>
                </tr>
                <tr>
                    <td><input type="checkbox" name="x33" value="-3">-3</td>
                    <td><input type="checkbox" name="x0" value="0"> 0</td>
                    <td><input type="checkbox" name="x3" value="3"> 3</td>
                </tr>
                <tr>
                    <td><input type="checkbox" name="x22" value="-2">-2</td>
                    <td><input type="checkbox" name="x1" value="1"> 1</td>
                    <td><input type="checkbox" name="x4" value="4"> 4</td>
                </tr>
            </table>
            <h3>2 шаг - Введите Y координату:</h3>
            <p><input type="text" pattern="(-[1-3])||(-[0-2](\.)[0-9]{1,2})||([0-5]||([0-4](\.)[0-9]{1,3}))" maxlength="5" size="6" name="y" placeholder=" от -3 до 5"></p>
            <span id="result"></span>
            <h3>3 шаг - Кликните по R:</h3>
            <p id="r"><input id="r1" name="r" type="radio" value="1"> 1
                <input id="r2" name="r" type="radio" value="2"> 2
                <input id="r3" name="r" type="radio" value="3"> 3
                <input id="r4" name="r" type="radio" value="4"> 4
                <input id="r5" name="r" type="radio" value="5"> 5</p>
            <button id="bttn" type="submit">Получить результат</button>
        </form>
        <br>
    </div>
    <div id="frame" class="container">
        <h3>Результаты:</h3>
        <span id="results1"></span>
        <iframe id="if" name = "graphics" height="575"></iframe>
    </div>
    <div class="clear"></div>
</div>
<footer>Copyright. All rights reserved. 2017 <br><br>
    <audio controls autoplay>
        <source src="sounds/welcome.mp3" type="audio/mpeg">
        Your browser does not support the audio element.
    </audio>
</footer>
</body>
</html>
<script>
    var plot_canvas = document.getElementById("plot");
    var plot_context = plot_canvas.getContext("2d");
    var rr = document.getElementById("r");

    plot_context.beginPath();
    plot_context.arc(150, 150, 100, 0, Math.PI/2);
    plot_context.lineTo(150, 150);
    plot_context.closePath();
    plot_context.rect(50, 150, 100, 50);
    plot_context.fillStyle = 'red';
    plot_context.fill();
    plot_context.beginPath();
    plot_context.moveTo(150, 150);
    plot_context.lineTo(150, 100);
    plot_context.lineTo(200, 150);
    plot_context.lineTo(150, 150);
    plot_context.closePath();
    plot_context.fillStyle = 'red';
    plot_context.fill();
    plot_context.beginPath();
    //Ox
    plot_context.moveTo(30, 150);
    plot_context.lineTo(270, 150);
    plot_context.lineTo(260, 140);
    plot_context.moveTo(270, 150);
    plot_context.lineTo(260, 160);
    //Oy
    plot_context.moveTo(150, 30);
    plot_context.lineTo(140, 40);
    plot_context.moveTo(150, 30);
    plot_context.lineTo(160, 40);
    plot_context.moveTo(150, 30);
    plot_context.lineTo(150, 270);

    plot_context.moveTo(30, 150);
    plot_context.closePath();
    plot_context.stroke();
    var x;
    var y;
    var R = '-1';
    rr.addEventListener("click", changeR, false);
    plot_canvas.addEventListener("click", drawPoint, false);

    function drawPoint(e) {
        $('#results1').hide();
        if(R == '-1') {
            alert("Выберите какое-нибудь значение R");
        } else {
            var cell = getCursorPosition(e);
            plot_context.beginPath();
            plot_context.rect(x, y, 5, 5);
            //plot_context.fillStyle = 'yellow';
            //plot_context.fill();
            x -= 150;
            y -= 150;
            y *= -1;
            x = x/100*R;
            y = y/100*R;
            //alert(x + " " + y);
            $.ajax({
                type:'post',//тип запроса: get,post либо head
                url:'controller',//url адрес файла обработчика
                data:{'x55':x, 'y':y, 'r':R},//параметры запроса
                response:'text',//тип возвращаемого ответа text либо xml
                error: function (message) {
                    console.log(message);
                    $('#results1').text(message);
                    alert("Error " + message);
                },
                success:function (data) {//возвращаемый результат от сервера
                    console.log(data);
                    //$('#results1').html(data);
                    /*$("#if").attr(
                        "src", "data:text/html;charset=utf-8," + data
                    );*/
                    ifr =   document.getElementById('if').contentDocument;
                    ifr.open();
                    ifr.writeln(data);
                    ifr.close();

                    var stra = $('#results1').html(data);
                    stra = stra.text();
                    //stra = stra.substr(453);
                    var numy = stra.search("true");
                    if(numy != -1) {
                        plot_context.fillStyle = 'green';
                    } else {
                        plot_context.fillStyle = 'red';
                    }
                    plot_context.fill();
                    //$('#results1').text(numy);
                    /*alert("Correct " + message);
                    $$('result',$$('result').innerHTML+'<br />'+data);*/
                }
            });

        }
    }
    function getCursorPosition(e) {
        if (e.pageX != undefined && e.pageY != undefined) {
            x = e.pageX;
            y = e.pageY;
        }
        else {
            x = e.clientX + document.body.scrollLeft +
                document.documentElement.scrollLeft;
            y = e.clientY + document.body.scrollTop +
                document.documentElement.scrollTop;
        }
        x -= plot_canvas.offsetLeft ;
        y -= plot_canvas.offsetTop ;
    }

    function changeR(ee) {
        if (document.getElementById('r1').checked) {
            R = document.getElementById('r1').value;
        }
        if (document.getElementById('r2').checked) {
            R = document.getElementById('r2').value;
        }
        if (document.getElementById('r3').checked) {
            R = document.getElementById('r3').value;
        }
        if (document.getElementById('r4').checked) {
            R = document.getElementById('r4').value;
        }
        if (document.getElementById('r5').checked) {
            R = document.getElementById('r5').value;
        }
    }
</script>