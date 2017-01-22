/**
 * Created by Li on 2017/1/4.
 */
window.onload = function () {
    //头部部分stare
    var header = document.getElementById("header");
    var ul = document.getElementById("music");
    var li = ul.children[0];
    var lis = ul.children;
    var btn2 = header.children[2];
    var btn1 = header.children[3];
    var search = document.getElementById("search");
    var mask = document.getElementById("mask");
    var show = document.getElementById("show");
    var close = document.getElementById("close");
    var enter = header.children[4];
    enter.onclick = function () {
        mask.style.display = "block";
        show.style.display = "block";
        close.style.display = "block";
    };
    btn2.onmousedown = function () {
        btn2.style.backgroundColor = "#31C27C";
        btn2.style.color = "#FFFFFF";
        btn2.style.borderColor = "#31C27C";
        btn1.style.backgroundColor = "#FFFFFF";
        btn1.style.color = "#333333";
        btn1.style.borderColor = "#E4E4E4";
    };
    btn1.onmousedown = function () {
        btn2.style.backgroundColor = "#FFFFFF";
        btn2.style.color = "#333333";
        btn2.style.borderColor = "#E4E4E4";
        btn1.style.backgroundColor = "#31C27C";
        btn1.style.color = "#FFFFFF";
        btn1.style.borderColor = "#31C27C";
    };
    search.onfocus = function () {
        if (this.value === "过去了 黄渤")
            this.value = "";
    };
    search.onblur = function () {
        if (this.value === "") {
            this.value = "过去了 黄渤";
        }
    };
    btn1.onclick = function () {
        mask.style.display = "block";
        show.style.display = "block";
        close.style.display = "block";
    };
    btn2.onclick = function () {
        mask.style.display = "block";
        show.style.display = "block";
        close.style.display = "block";
    };
    close.onclick = function () {
        mask.style.display = "none";
        show.style.display = "none";
        close.style.display = "none";
    };
    //头部部分end
    //头部下方部分stare
    var musicb = document.getElementById("musicb");
    var spans = musicb.children;
    for (var i = 0; i < spans.length; i++) {
        spans[i].onclick = function () {
            for (var i = 0; i < spans.length; i++) {
                spans[i].className = " ";
            }
            this.className = "musicall";
        };
    }
    //头部下方部分end
    //新歌首发部分stare
    var newmusic = document.getElementById("newmusic");
    var spans = newmusic.children[0].children[1].children;
    for (var i = 0; i < spans.length; i++) {
        spans[i].onclick = function () {
            for (var i = 0; i < spans.length; i++) {
                spans.className = "";
            }
            this.className = "music";
        };
    }
    var musiclb = newmusic.children[1];
    var musiclb1 = document.getElementById("musiclb1");
    var arr = newmusic.children[2];
    var arrl = arr.children[0];
    var arrr = arr.children[1];
    var musiclb1ul = musiclb1.children[0];
    var ullis = musiclb1ul.children;
    var pic = 0;
    var square = 0;
    var timerauto = null;
    var imgWidth = musiclb1.offsetWidth;
    newmusic.onmouseover = function () {
        arr.style.display = "block";
    };
    newmusic.onmouseout = function () {
        arr.style.display = "none";
    };
    arrl.onmouseover = function () {
        clearInterval(timerauto);
        arrl.style.backgroundColor = "#31C27C";
        animate(arrl, {"width": 70});
    };
    arrl.onmouseout = function () {
        arrl.style.backgroundColor = "#373737";
        animate(arrl, {"width": 50});
        timerauto = setInterval(function () {
            arrr.onclick();
        }, 3000);
    };
    arrr.onmouseover = function () {
        clearInterval(timerauto);
        arrr.style.backgroundColor = "#31C27C";
        animate(arrr, {"width": 70});
    };
    arrr.onmouseout = function () {
        arrr.style.backgroundColor = "#373737";
        animate(arrr, {"width": 50});
        timerauto = setInterval(function () {
            arrr.onclick();
        }, 3000);
    };
    arrr.onclick = function () {
        if (pic === ullis.length - 1) {
            musiclb1ul.style.left = 0;
            pic = 0;
        }
        pic++;
        var target = -pic * imgWidth;
        animate1(musiclb1ul, target);
        if (square < olLis.length - 1) {
            square++;
        } else {
            square = 0;
        }
        for (var i = 0; i < olLis.length; i++) {
            olLis[i].className = "";
        }
        olLis[square].className = "ol1";
    };
    arrl.onclick = function () {
        if (pic === 0) {
            musiclb1ul.style.left = -(ullis.length - 1) * imgWidth + "px";
            pic = ullis.length - 1;
        }
        pic--;
        var target = -pic * imgWidth;
        animate1(musiclb1ul, target);
        if (square > 0) {
            square--;
        } else {
            square = olLis.length - 1;
        }
        for (var i = 0; i < olLis.length; i++) {
            olLis[i].className = "";
        }
        olLis[square].className = "ol1";
    };
    var ol = newmusic.children[3];
    var olLis = ol.children;
    for (var i = 0; i < olLis.length; i++) {
        olLis[i].index = i;
        olLis[i].onmouseover = function () {
            clearInterval(timerauto);
            for (var i = 0; i < olLis.length; i++) {
                olLis[i].className = "";
            }
            this.className = "ol1";
            //鼠标经过标签让盒子移动
            var target = -this.index * imgWidth;
            animate1(musiclb1ul, target);
            square = pic = this.index;
        };
    }

    var plays = musiclb1.getElementsByTagName("s");
    var newImg = musiclb1.getElementsByTagName("img");
    for (var i = 0; i < newImg.length; i++) {
        newImg[i].onmouseover = function () {
            clearInterval(timerauto);
            for (var i = 0; i < newImg.length; i++) {
                animate(newImg[i], {"width": 300, "height": 300});
            }
            animate(this, {"width": 315, "height": 315});
        };
        newImg[i].onmouseout = function () {
            timerauto = setInterval(function () {
                arrr.onclick();
            }, 3000);
            for (var i = 0; i < newImg.length; i++) {
                animate(newImg[i], {"width": 300, "height": 300});
            }
        };
    }
    var clear1 = document.getElementById("clear1");
    var clearLis1 = clear1.getElementsByTagName("li");
    var clear2 = document.getElementById("clear2");
    var clearLis2 = clear2.getElementsByTagName("li");
    var clear3 = document.getElementById("clear3");
    var clearLis3 = clear3.getElementsByTagName("li");
    var clear4 = document.getElementById("clear4");
    var clearLis4 = clear4.getElementsByTagName("li");
    for (var i = 0; i < clearLis1.length; i++) {
        clearLis1[i].onmouseover = function () {
            clearInterval(timerauto);
        }
        clearLis1[i].onmouseout = function () {
            clearInterval(timerauto);
            timerauto = setInterval(function () {
                arrr.onclick();
            }, 3000);
        }
    }
    for (var i = 0; i < clearLis2.length; i++) {
        clearLis2[i].onmouseover = function () {
            clearInterval(timerauto);
        }
        clearLis2[i].onmouseout = function () {
            clearInterval(timerauto);
            timerauto = setInterval(function () {
                arrr.onclick();
            }, 3000);
        }
    }
    for (var i = 0; i < clearLis3.length; i++) {
        clearLis3[i].onmouseover = function () {
            clearInterval(timerauto);
        }
        clearLis3[i].onmouseout = function () {
            clearInterval(timerauto);
            timerauto = setInterval(function () {
                arrr.onclick();
            }, 3000);
        }
    }
    for (var i = 0; i < clearLis4.length; i++) {
        clearLis4[i].onmouseover = function () {
            clearInterval(timerauto);
        }
        clearLis4[i].onmouseout = function () {
            clearInterval(timerauto);
            timerauto = setInterval(function () {
                arrr.onclick();
            }, 3000);
        }
    }
    //自动播放
    timerauto = setInterval(function () {
        arrr.onclick();
    }, 3000);
    //新歌首发部分end
    //精彩推荐stare
    var config = [
        {
            "width": 400,
            "top": 70,
            "left": 50,
            "opacity": 0.2,
            "zIndex": 2
        },
        {
            "width": 600,
            "top": 70,
            "left": 0,
            "opacity": 0.8,
            "zIndex": 3
        },
        {
            "width": 800,
            "height": 70,
            "top": 20,
            "left": 200,
            "opacity": 1,
            "zIndex": 4
        },
        {
            width: 600,
            top: 70,
            left: 600,
            opacity: 0.8,
            zIndex: 3
        },
        {
            "width": 400,
            "top": 70,
            "left": 750,
            "opacity": 0.2,
            "zIndex": 2
        },
        {
            "width": 400,
            "top": 70,
            "left": 750,
            "opacity": 0.2,
            "zIndex": 2
        }
    ];
    var wrap = document.getElementById("wrap");
    var lis = wrap.getElementsByTagName("li");
    var arrow = document.getElementById("arrow");
    var arrLeft = document.getElementById("arrLeft");
    var arrRight = document.getElementById("arrRight");
    var slide = document.getElementById("slide");
    var ul = slide.getElementsByTagName("ul");
    var two = document.getElementById("two");
    var span = two.getElementsByTagName("span");
    var imgWidth = slide.offsetWidth;
    var span = two.getElementsByTagName("span");
    var index = 0;
    wrap.onmouseover = function () {

        animate(arrow, {"opacity": 1});
    };
    wrap.onmouseout = function () {
        animate(arrow, {"opacity": 0});
    };
    function assign() {
        for (var i = 0; i < lis.length; i++) {
            animate(lis[i], config[i], function () {
                flag = true;

            });
        }
    }

    assign();

    arrRight.onclick = function () {
        index++;
        index = index > span.length - 1 ? 0 : index;
        for (var i = 0; i < span.length; i++) {
            span[i].className = "";
        }
        span[index].className = "current";
        if (flag) {
            flag = false;
            config.push(config.shift());
            assign();
        }
    };
    arrLeft.onclick = function () {
        index--;
        index = index < 0 ? span.length - 1 : index;
        for (var i = 0; i < span.length; i++) {
            span[i].className = "";
        }
        span[index].className = "current";
        config.unshift(config.pop());
        assign();
    }
    var flag = true;


    for (var i = 0; i < span.length; i++) {
        span[i].index = i;
        span[i].onmouseover = function () {

            for (var i = 0; i < span.length; i++) {
                span[i].className = "";
            }
            this.className = "current";
            if (this.index > index) {
                flag = false;
                config.push(config.shift());
                assign();
            }
            if (this.index < index) {
                flag = false;
                config.unshift(config.pop());
                assign();
            }
            index = this.index;
        }
    }
    //精彩推荐end
    //排行榜部分stare
    var bgcpic = document.getElementById("bgcpic");
    var topbg = bgcpic.getElementsByTagName("s");
    var musicName1 = document.getElementById("musicName1");
    var musicName1Lis = musicName1.children;
    var musicName2 = document.getElementById("musicName2");
    var musicName2Lis = musicName2.children;
    var musicName3 = document.getElementById("musicName3");
    var musicName3Lis = musicName3.children;
    var musicName4 = document.getElementById("musicName4");
    var musicName4Lis = musicName4.children;
    for (var i = 0; i < topbg.length; i++) {
        topbg[i].style.background = "url(images/bg_index_top.jpg) " + (-300 * i) + "px 0px no-repeat";
    }

    for (var i = 0; i < musicName1Lis.length; i++) {
        musicName1Lis[i].onmouseover = function () {
            for (var i = 0; i < musicName1Lis.length; i++) {
                musicName1Lis[i].style.transform = "translateZ(10px) scale(1)";
            }
            this.style.transform = "translateZ(10px) scale(1.1)";
        };
        musicName1Lis[i].onmouseout = function () {
            for (var i = 0; i < musicName1Lis.length; i++) {
                this.style.transform = "translateZ(10px) scale(1)";
            }
        };
    }
    for (var i = 0; i < musicName2Lis.length; i++) {
        musicName2Lis[i].onmouseover = function () {
            for (var i = 0; i < musicName2Lis.length; i++) {
                musicName2Lis[i].style.transform = "translateZ(10px) scale(1)";
            }
            this.style.transform = "translateZ(10px) scale(1.1)";
        };
        musicName2Lis[i].onmouseout = function () {
            for (var i = 0; i < musicName2Lis.length; i++) {
                this.style.transform = "translateZ(10px) scale(1)";
            }
        };
    }
    for (var i = 0; i < musicName3Lis.length; i++) {
        musicName3Lis[i].onmouseover = function () {
            for (var i = 0; i < musicName3Lis.length; i++) {
                musicName3Lis[i].style.transform = "translateZ(10px) scale(1)";
            }
            this.style.transform = "translateZ(10px) scale(1.1)";
        };
        musicName3Lis[i].onmouseout = function () {
            for (var i = 0; i < musicName3Lis.length; i++) {
                this.style.transform = "translateZ(10px) scale(1)";
            }
        };
    }
    for (var i = 0; i < musicName4Lis.length; i++) {
        musicName4Lis[i].onmouseover = function () {
            for (var i = 0; i < musicName4Lis.length; i++) {
                musicName4Lis[i].style.transform = "translateZ(10px) scale(1)";
            }
            this.style.transform = "translateZ(10px) scale(1.1)";
        };
        musicName4Lis[i].onmouseout = function () {
            for (var i = 0; i < musicName4Lis.length; i++) {
                this.style.transform = "translateZ(10px) scale(1)";
            }
        };
    }
    //排行榜部分end
    //热门歌单部分stare
    var wu1s = document.getElementById("wu1");
    var wu2s = document.getElementById("wu2");
    var wu3s = document.getElementById("wu3");
    var wu4s = document.getElementById("wu4");
    var bfs = document.getElementById("bf");
    var bfs1 = document.getElementById("bf1");
    var bfs2 = document.getElementById("bf2");
    var bfs3 = document.getElementById("bf3");
    var three1s = document.getElementById("three1");
    var three2s = document.getElementById("three2");
    var three3s = document.getElementById("three3");
    var three4s = document.getElementById("three4");
    var to1 = document.getElementById("to1");
    var to2 = document.getElementById("to2");
    var to3 = document.getElementById("to3");
    var to4 = document.getElementById("to4");
    var qq = document.getElementById("qq");
    var qq0 = document.getElementById("qq0");
    var img = document.getElementsByTagName("img");


    //three1s.onmouseover = function(){
    //    if(event.currentTarget!=this) {
    //        return false;
    //    }
    //    three1s.style.backgroundColor="#31C27C";
    //
    //}
    //three1s.onmouseout =function(){
    //    three1s.style.backgroundColor="#333333";
    //}
    wu1s.onmouseover = function (event) {
        //if(event.currentTarget!=this) {
        //    return false;
        //}
        //animate(wu1s,{"width":305,"heigth":300});
        wu1s.style.transform = "translateZ(20px) scale(1.02)";
        three1s.style.backgroundColor = "#31C27C";
        animate(bfs, {"opacity": 1});
    }
    wu1s.onmouseout = function () {
        //animate(wu1s,{"width":300,"heigth":300});
        wu1s.style.transform = "translateZ(20px) scale(1)";
        three1s.style.backgroundColor = "#333333";
        animate(bfs, {opacity: "0"});
    }
    bfs.onmouseover = function () {
        wu1s.onmouseover();
    };


    //three2s.onmouseover = function(){
    //    if(event.currentTarget!=this) {
    //        return false;
    //    }
    //    three2s.style.backgroundColor="#31C27C";
    //
    //}
    //three2s.onmouseout =function(){
    //    three2s.style.backgroundColor="#414141";
    //}
    wu2s.onmouseover = function (event) {
        //if(event.currentTarget!=this) {
        //    return false;
        //}
        wu2s.style.transform = "translateZ(20px) scale(1.02)";
        three2s.style.backgroundColor = "#31C27C";
        animate(bfs1, {"opacity": 1});
    }
    wu2s.onmouseout = function () {
        animate(bfs1, {opacity: "0"});
        wu2s.style.transform = "translateZ(20px) scale(1)";
        three2s.style.backgroundColor = "#414141";
    }
    bfs1.onmouseover = function () {
        wu2s.onmouseover();
    };


    //three3s.onmouseover = function(){
    //    if(event.currentTarget!=this) {
    //        return false;
    //    }
    //    three3s.style.backgroundColor="#31C27C";
    //
    //}
    //three3s.onmouseout =function(){
    //    three3s.style.backgroundColor="#333333";
    //}
    wu3s.onmouseover = function (event) {
        //if(event.currentTarget!=this) {
        //    return false;
        //}
        wu3s.style.transform = "translateZ(20px) scale(1.02)";
        three3s.style.backgroundColor = "#31C27C";
        animate(bfs2, {"opacity": 1});
    }
    wu3s.onmouseout = function () {
        animate(bfs2, {opacity: "0"});
        wu3s.style.transform = "translateZ(20px) scale(1)";
        three3s.style.backgroundColor = "#333333";
    }
    bfs2.onmouseover = function () {
        wu3s.onmouseover();
    };

    //three4s.onmouseover = function(){
    //    if(event.currentTarget!=this) {
    //        return false;
    //    }
    //    three4s.style.backgroundColor="#31C27C";
    //
    //}
    //three4s.onmouseout =function(){
    //    three4s.style.backgroundColor="#414141";
    //}
    wu4s.onmouseover = function (event) {
        //if(event.currentTarget!=this) {
        //    return false;
        //}
        wu4s.style.transform = "translateZ(20px) scale(1.02)";
        three4s.style.backgroundColor = "#31C27C";
        animate(bfs3, {"opacity": 1});
    }
    wu4s.onmouseout = function () {
        animate(bfs3, {opacity: "0"});
        wu4s.style.transform = "translateZ(20px) scale(1)";
        three4s.style.backgroundColor = "#414141"
    }
    bfs3.onmouseover = function () {
        wu4s.onmouseover();
    };

    //qq.onmouseover=function(){
    //    animate(qq0,{"opacity":1});
    //};

//    qq.onmouseup=function(){
//        animate(qq0,{"opacity":0})
//    }

    //热门歌单部分end
    //MV首播stare
    var mtplay = document.getElementById("mtplay");
    var imgs = mtplay.getElementsByTagName("img");
    var mvplayes = mtplay.getElementsByTagName("e");
    for (var i = 0; i < imgs.length; i++) {
        imgs[i].onmouseover = function () {
            for (var i = 0; i < imgs.length; i++) {
                //imgs[i].style.transform = "translateZ(10px) scale(1)";
                animate(imgs[i], {"width": 300, "height": 153});
            }
            animate(this, {"width": 315, "height": 165});
            //this.style.transform = "translateZ(10px) scale(1.2)";
            //this.style.zIndex=2;
        };
        imgs[i].onmouseout = function () {
            for (var i = 0; i < imgs.length; i++) {
                this.style.transform = "translateZ(10px) scale(1)";
                //this.style.zIndex=1;
                animate(imgs[i], {"width": 300, "height": 153});
            }
        };
    }
    //MV首播end
    //排行榜部分end

    //尾部部分stare

    //尾部部分end
    //返回网页顶部部分stare
    var back = document.getElementById("back");
    var backTop = back.children[0];
    var backW = back.children[1];
    var backP = back.children[2];
    var timer = null;
    window.onscroll = function () {
        backTop.style.display = scroll().top > 0 ? "block" : "none";
    };
    backTop.onclick = function () {
        timer = setInterval(function () {
            var target = 0;
            var leader = scroll().top;
            var step = (target - leader) / 10;
            step = step > 0 ? Math.ceil(step) : Math.floor(step);
            leader = leader + step;
            window.scrollTo(0, leader);
            if (leader === target) {
                clearInterval(timer);
            }
        }, 15);
    };
    backTop.onmouseover = function () {
        backover(backTop);
    };
    backTop.onmouseout = function () {
        backout(backTop);
    };
    backW.onmouseover = function () {
        backover(backW);
    };
    backW.onmouseout = function () {
        backout(backW);
    };
    backP.onmouseover = function () {
        backover(backP);
    };
    backP.onmouseout = function () {
        backout(backP);
    };
    function backover(obj) {
        animate(obj, {"width": 60});
    }

    function backout(obj) {
        animate(obj, {"width": 50});
    }

    //返回网页顶部部分end
};