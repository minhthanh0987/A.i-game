<!DOCTYPE html>
<html>
<head>
<title>Horror Night</title>
<meta charset="utf-8">
<style>
body{
    background:black;
    color:white;
    font-family:Arial;
    text-align:center;
}
#game, #office, #gameover{
    display:none;
}
button{
    padding:10px 20px;
    margin:10px;
    font-size:18px;
}
#power{
    font-size:22px;
    margin-top:20px;
}
.enemy{
    color:red;
    font-size:24px;
    margin-top:30px;
}
</style>
</head>

<body>

<h1 id="title">HORROR NIGHT</h1>

<div id="menu">
    <p>New Job. Night Shift. 21PM - 5AM</p>
    <button onclick="startGame()">Start Game</button>
</div>

<div id="game">
    <h2 id="nightText">Night 1</h2>
    <div id="office">
        <p>⚠️ Hãy sống sót đến 5:00</p>
        <button onclick="checkDoor()">Check Door</button>
        <button onclick="closeDoor()">Close Door</button>
        <button onclick="useLight()">Use Light</button>

        <div id="power">Power: 100%</div>
        <div id="time">Time: 21:00</div>

        <div class="enemy" id="enemy"></div>
    </div>
</div>

<div id="gameover">
    <h1>GAME OVER</h1>
    <p id="reasonText"></p>
    <button onclick="restart()">Retry</button>
</div>

<script>
let power = 100;
let hour = 21;
let alive = true;
let enemyNear = false;

function startGame(){
    document.getElementById("menu").style.display="none";
    document.getElementById("game").style.display="block";
    document.getElementById("office").style.display="block";

    gameLoop = setInterval(update,2000);
}

function update(){
    if(!alive) return;

    // đồng hồ
    hour++;
    if(hour >= 24){
        hour = 0;
    }

    document.getElementById("time").innerText = "Time: " + hour + ":00";

    // thắng
    if(hour >= 5){
        win();
        return;
    }

    // địch tiến lại
    if(Math.random() < 0.5){
        enemyNear = true;
        document.getElementById("enemy").innerText="Animatronic đang ở ngay cửa!";
    }

    // hết điện = chết
    if(power <= 0){
        gameOver("Bạn hết điện và bị Fredy tóm!");
    }
}

function checkDoor(){
    power -= 3;
    if(enemyNear){
        enemyNear = false;
        document.getElementById("enemy").innerText="Bạn đã đuổi nó đi!";
    } else {
        document.getElementById("enemy").innerText="Không có ai...";
    }
    updatePower();
}

function closeDoor(){
    power -= 8;
    enemyNear = false;
    document.getElementById("enemy").innerText="Bạn đã đóng cửa!";
    updatePower();
}

function useLight(){
    power -= 5;
    document.getElementById("enemy").innerText="Bạn bật đèn kiểm tra khu vực!";
    updatePower();
}

function updatePower(){
    if(power < 0) power = 0;
    document.getElementById("power").innerText="Power: " + power + "%";
}

function win(){
    clearInterval(gameLoop);
    alert("Bạn đã sống sót đến 5:00! GOOD ENDING");
}

function gameOver(reason){
    alive = false;
    clearInterval(gameLoop);
    document.getElementById("game").style.display="none";
    document.getElementById("gameover").style.display="block";
    document.getElementById("reasonText").innerText = reason;
}

function restart(){
    location.reload();
}
</script>

</body>
</html>