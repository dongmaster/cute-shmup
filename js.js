//currentBlock = Qt.createComponent('block.qml').createObject(root, {"x": mouse.x-block/2, "y": mouse.y-block/2});

var enemy_limit = 70;


var bullet_width = 10;
var bullet_height = 18;

var enemy1_health = 10;
var enemy2_health = 25;

var shooting = false;

var fpscounter = 0;


function rnum(input) {
    return Math.floor(Math.random() * input + 1)
}

function rnum2(min, max) { //Provides a random number between two values
    return Math.floor(Math.random() * (max+1 - min) ) + min;
}

function remove(arr, item) {
   var i;
   while((i = arr.indexOf(item)) !== -1) {
     arr.splice(i, 1);
   }
}

function isColliding(param1, param2) { //Function for handling collision. praise google
    return (param1.x < param2.x + param2.width) && (param1.y < param2.y + param2.height) && (param1.x + param1.width > param2.x) && (param1.y + param1.height > param2.y);
}

var bullet_counter = 0;

function shoot() {
    var bullet1 = Qt.createComponent('bullet.qml').createObject(root, {"x": mousearea.mouseX - bullet_width / 2, "y": mousearea.mouseY - player.height});
    var bullet2 = Qt.createComponent('bullet.qml').createObject(root, {"x": mousearea.mouseX - hitbox.width - bullet_width * 1.5, "y": mousearea.mouseY - player.height});
    var bullet3 = Qt.createComponent('bullet.qml').createObject(root, {"x": mousearea.mouseX - bullet_width + bullet_width * 2.5, "y": mousearea.mouseY - player.height});

    bullet2.x = hitbox.x - hitbox.width - 300;
    // The reason for the 130 here is because it looks weird and asymmetrical if you use 100. Magic number.
    bullet3.x = hitbox.x + hitbox.width + 300;

    root.bullet_array.push(bullet1);
    root.bullet_array.push(bullet2);
    root.bullet_array.push(bullet3);


    //current_bullet.x = mousearea.mouseX - player.width / 2 + rnum2(-100, 100);
}



function create_enemy() {
    if(root.enemy_array.length < enemy_limit && root.boss_mode === false) {
        var enemy = Qt.createComponent('enemy1.qml').createObject(root, {"x": rnum(root.width), "y": rnum2(-400, -50)});
        enemy.x = rnum(root.width - enemy.width);
        enemy.y = rnum2(0, 200);



        root.enemy_array.push(enemy)
    }



    //console.log(enemy.x, enemy.y)
}

function create_enemy2() {
    if(root.enemy_array.length < enemy_limit && root.boss_mode === false) {
        var enemy = Qt.createComponent('enemy2.qml').createObject(root, {"x": rnum(root.width), "y": rnum2(-400, -50)});
        enemy.x = rnum(root.width - enemy.width);
        enemy.y = rnum2(0, 200);

        root.enemy_array.push(enemy)
    }
}

function create_boss() {
    var boss = Qt.createComponent('boss1.qml').createObject(root, {"x": root.width / 2, "y": rnum2(-400, -50)});
    boss.y = boss.height + 5;

    level_switch.stop();

    root.enemy_array.push(boss);
}

function create_boss2() {
    var boss = Qt.createComponent('boss2.qml').createObject(root, {"x": root.width / 2, "y": rnum2(-400, -50)});
    boss .y = boss.height + 5;

    level_switch.stop();

    root.enemy_array.push(boss);
}

var god_counter = 0;

function toggle_god() {
    switch(player.god) {
        case false:
            player.god = true;
            break;

        case true:
            player.god = false;
            break;
    }
}

// Checks collision between bullets and enemies. Handles bullet destruction and enemy destruction.
// Also removes the entries from the bullet and enemy arrays.
function check_collision() {
    for(var i = 0; i < root.bullet_array.length; i++) {
        for(var j = 0; j < root.enemy_array.length; j++) {
            if(isColliding(root.bullet_array[i], root.enemy_array[j]) === true && root.enemy_array[j].y > -10) {
                // If a bullet hits an enemy, decrease health of enemy and destroy bullet.
                root.bullet_array[i].destroy();

                root.enemy_array[j].health--;

                remove(root.bullet_array, root.bullet_array[i]);

                for(var i = 0; i <= 2; i++) {
                    var explosion = Qt.createComponent('explosion.qml').createObject(root, {'x': root.enemy_array[j].x, 'y': root.enemy_array[j].y});
                    explosion.destroy(500);
                }

                if(root.enemy_array[j].health <= 0) {
                    // If the health of the enemy is 0 or less, do this:
                    player.score += root.enemy_array[j].score_gain;

                    if(root.enemy_array[j].is_boss === true) {
                        root.boss_mode = false;
                        root.level++;

                        level_switch.start();
                    }

                    root.enemy_array[j].destroy();
                    remove(root.enemy_array, root.enemy_array[j]);

                }
            }
        }
    }
}

function special_ability() {
    //var bullet1 = Qt.createComponent('bullet.qml').createObject(root, {"x": mousearea.mouseX - bullet_width / 2, "y": mousearea.mouseY - player.height});
    /*
    var bullet1 = Qt.createComponent('special_bullet.qml').createObject(root, {"x": mousearea.mouseX, "y": mousearea.mouseY});
    bullet1.x = root.width / 2;
    bullet1.y = root.height / 2;
    */
    for(var k = 0; k < 20; k++) {
        for(var i = 0; i < root.enemy_array.length; i++) {
            root.enemy_array[i].destroy();
            remove(root.enemy_array, root.enemy_array[i]);
        }
/*
        for(var j = 0; j < root.bullet_array.length; j++) {
            root.bullet_array[j].destroy();
            remove(root.bullet_array, root.bullet_array[j]);
        }
        */
    }
    /*
    var bullet1 = Qt.createComponent('bullet.qml').createObject(root, {"x": mousearea.mouseX - bullet_width / 2, "y": mousearea.mouseY - player.height});
    bullet1.x = rnum(root.width);

    root.bullet_array.push(bullet1);

    root.bullet_array[rnum(root.bullet_array.length - 1)].x = rnum(root.width + 100);
    */
}

function punish() {
    var pbullet = Qt.createComponent('punishment.qml').createObject(root, {"x": -500, "y": rnum(root.height)});
}

function restart() {
    player.health = 10;
    player.visible = true;
    game_over_text.visible = false;
    player.can_shoot = true;
    player.score = 0;
    root.level = 1;
    level_switch.restart();
    root.boss_mode = false;

    for(var k = 0; k < 20; k++) {
        for(var i = 0; i < root.enemy_array.length; i++) {
            root.enemy_array[i].destroy();
            remove(root.enemy_array, root.enemy_array[i]);
        }

        for(var j = 0; j < root.bullet_array.length; j++) {
            root.bullet_array[j].destroy();
            remove(root.bullet_array, root.bullet_array[j]);
        }
    }

}


