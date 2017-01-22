<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="CSS/base.css">
        <link rel="stylesheet" href="CSS/index.css">
        <link rel="icon" href="images/small.ico" type="image/x-icon" /> 
        
        <style>
         * {
            padding: 0;
            margin: 0;
            list-style: none;
            border: 0;
        }

        .all {
            width: 500px;
            height: 200px;
            padding: 7px;
           /*  border: 1px solid #ccc; */
            /* margin: 100px auto; */
            position: relative;
        }

        .screen {
            width: 500px;
            height: 200px;
            overflow: hidden;
            position: relative;
        }

        .screen li {
            width: 500px;
            height: 200px;
            overflow: hidden;
            float: left;
        }

        .screen ul {
            position: absolute;
            left: 0;
            top: 0px;
            width: 3000px;
        }

        .all ol {
            position: absolute;
            right: 10px;
            bottom: 10px;
            line-height: 20px;
            text-align: center;
        }

        .all ol li {
            float: left;
            width: 20px;
            height: 20px;
            background: #fff;
            border: 1px solid #ccc;
            margin-left: 10px;
            cursor: pointer;
        }

        .all ol li.current {
            background: yellow;
        }

        #arr {
            display: none;
        }

        #arr span {
            width: 40px;
            height: 40px;
            position: absolute;
            left: 5px;
            top: 50%;
            margin-top: -20px;
            background: #000;
            cursor: pointer;
            line-height: 40px;
            text-align: center;
            font-weight: bold;
            font-family: '黑体';
            font-size: 30px;
            color: #fff;
            opacity: 0.3;
            border: 1px solid #fff;
        }

        #arr #right {
            right: 5px;
            left: auto;
        }
    </style>
       <script>
    //1 先根据图片张数，创建小方块
    var box = document.getElementById("box");
    var screen = box.children[0];
    var arr = box.children[1];
    var ul = screen.children[0];
    var ol = screen.children[1];
    var lisUl = ul.children;

    var imgWid = screen.offsetWidth;

    var arrRight = arr.children[1];
    var arrLeft = arr.children[0];

    var timer = null;

    //遍历lisUl
    for (var i = 0; i < lisUl.length; i++) {
        var li = document.createElement("li");
        li.innerHTML = i + 1;
        ol.appendChild(li);
    }

    //制作小方块的点击变色效果
    var lisOl = ol.children;
    //先让第一个小方块显示
    lisOl[0].className = "current";

    for (var i = 0; i < lisOl.length; i++) {
        //添加自定义属性。用于保存索引
        lisOl[i].index = i;
        lisOl[i].onclick = function () {
            //点击小方块的时候进行判断，如果pic的值为length-1，直接抽回为0
            if (pic == lisUl.length - 1) {
                ul.style.left = 0 + "px";
            }

            //排他
            for (var i = 0; i < lisOl.length; i++) {
                lisOl[i].className = "";
            }
            //给自己设置
            this.className = "current";

            //让ul运动到指定位置
            //根据当前按钮的索引让ul运动
            animate(ul, -this.index * imgWid);

            //在点击小方块的时候，需要让pic的值同步
            pic = this.index;
        };
    }

    //2 左右点击效果

    //一次执行是翻一个新页 ,切记，时间不要太短
    timer = setInterval(play, 1500);


    // 移入移出显示左右箭头
    box.onmouseover = function () {
        arr.style.display = "block";
        //停止自动播放
        clearInterval(timer);
    };

    box.onmouseout = function () {
        arr.style.display = "none";
        //移出再次开启
        timer = setInterval(play, 1500);
    };


    //必须在创建小方块的后面
    //克隆第一张图片，用于制作无缝滚动
    var firstPic = lisUl[0].cloneNode(true);
    ul.appendChild(firstPic);


    //用于控制滚过的图片张数
    var pic = 0;
    //点击右按钮效果
    arrRight.onclick = function () {
        play();
    };

    //左按钮
    arrLeft.onclick = function () {
        if (pic == 0) {
            //当前如果显示的是第一张时，再次点击，需要先抽回到假的第一张显示的位置
            ul.style.left = -(ul.offsetWidth - imgWid) + "px";
            //pic也要归为length-1
            pic = lisUl.length - 1;
        }
        pic--;
        animate(ul, -pic * imgWid);

        //排他
        for (var i = 0; i < lisOl.length; i++) {
            lisOl[i].className = "";
        }
        //点击左按钮时，由于不会完全显示假的第一张，不会取到他的索引，不用单独处理了
        lisOl[pic].className = "current";
    }


    function play() {
        if (pic == lisUl.length - 1) {
            //如果当前已经显示了假的第一张，再次点击时，需要先进行抽回
            ul.style.left = 0;
            //将pic归0
            pic = 0;
        }
        pic++;
        var target = -pic * imgWid;
        animate(ul, target);

        //点击左右按钮时，让下面的小方块显示 可以使用lisOl[pic]

        //需要排他
        for (var i = 0; i < lisOl.length; i++) {
            lisOl[i].className = "";
        }

        //点亮的时候需要判断。如果当前显示的是假的第一张，应该让lisOl[0]点亮
        if (pic == lisUl.length - 1) {
            lisOl[0].className = "current";
        } else {
            //点击右按钮时，用pic作为索引，让lisOl中对应的li显示
            lisOl[pic].className = "current";
        }


    }


    //让某个标签移动到指定位置
    function animate(tag, target) {
        clearInterval(tag.timer);
        tag.timer = setInterval(function () {
            //第一步 获取当前位置
            var leader = tag.offsetLeft;
            var step = 17;
            //第二部 检测步数的正负
            if (leader > target) {
                step = -step;
            }

            //有可能在运动的时候，走了一个step超过了target的位置，造成了抖动
            if (Math.abs(leader - target) > Math.abs(step)) {
                leader = leader + step;
                tag.style.left = leader + "px";
            } else {
                //需要走到终点
                tag.style.left = target + "px";
                clearInterval(tag.timer);
            }
        }, 17);
    }
</script>

    </head>
    <body>

   		 <!-- 头部开始 -->
   		 <div class="header">
   		 	
   		 	  <div class="w">
   		 	  	  <div class="l-header">
   		 	  	  	  你好，欢迎来到顾北的小网站
   		 	  	  </div>
   		 	  	  <div class="r-nav">
   		 	  	  	 <ul>
   		 	  	  	 	 <li><a href="#">首页</a></li>
				     	 <li class="li-bg"><a href="#">个人中心</a></li>
				     	 <li class="li-bg"><a href="#">微博</a></li>
				     	 <li class="li-bg"><a href="#">登陆</a></li>
				     	 <li><a href="#">注册</a></li>
				     	 <li class="li-bg"><a href="#">手机登陆</a></li>
   		 	  	  	 </ul>
   		 	  	  </div>
   		 	  </div>
   		 </div>

         <!-- 版心开始 -->
         <div class="mainbody w">
         	
         	  <!-- logo部分开始 -->
 			  <div class="logo clearfix">
 			  			
 			  		<!-- 左logo -->
 			  		<div class="l-logo">
 			  			  <a href="#">顾北</a>
 			  		</div>
				
				    <!-- 右侧搜索 -->
 			  		<div class="r-search">
 			  			 <input type="text" value="请输入条件" class="search">
 			  			 <input type="button" class="btn">
 			  		</div>
 			  </div>

			  <!-- 导航开始 -->
 			  <div class="nav">
 			  		 <ul>
					     <li><a href="#" class="a-bg">图片</a></li>
					     <li><a href="#">专栏</a></li>
					     <li><a href="#">时事热点</a></li>
					     <li><a href="#">其他</a></li>
					 </ul>
 			  </div>

 			  <!-- Banner部分开始 -->
 			  <div class="banner clearfix">
 			  		<!-- 左侧盒子开始 -->
 			  		<div class="l-side">
 			  			<div class="title">
 			  				 <h4>娱乐事件</h4>
 			  			</div>

 			  			<div class="content">
 			  				<ul>
								<li><a href="#">张杰</a></li>
								<li><a href="#">吴亦凡</a></li>
								<li><a href="#">鹿晗</a></li>
								<li><a href="#">张艺兴</a></li>
								<li><a href="#">谢娜</a></li>
								<li><a href="#">邓超</a></li>
							</ul>
 			  			</div>
 			  		</div>
					 <!-- 中间banner -->
 			  		<div class="all" id='box'>
                      <div class="screen">
                        <ul>
                           <li><img src="images/1.jpg" width="500" height="200"/></li>
                           <li><img src="images/2.jpg" width="500" height="200"/></li>
                           <li><img src="images/3.jpg" width="500" height="200"/></li>
                           <li><img src="images/4.jpg" width="500" height="200"/></li>
                           <li><img src="images/5.jpg" width="500" height="200"/></li>
                        </ul>
                      <ol>
                       <!-- 动态创建的小方块，添加在这里，样式已经给写好了-->
                      </ol>
                      </div>
                      <div id="arr"><span id="left">&lt;</span><span id="right">&gt;</span></div>
                    </div>


 			  		<!-- 右侧盒子 -->
 			  		<div class="r-side">
 			  			

 			  			 <div class="title">
 			  				 <h4>娱乐事件</h4>
 			  			</div>

 			  			<div class="content">
 			  				<ul>
								<li><a href="#">张杰</a></li>
								<li><a href="#">吴亦凡</a></li>
								<li><a href="#">鹿晗</a></li>
								<li><a href="#">张艺兴</a></li>
								<li><a href="#">谢娜</a></li>
								<li><a href="#">邓超</a></li>
							</ul>
 			  			</div>
 			  		</div>
 			  </div>

			   <!-- 猜你喜欢 -->
			   <div class="public-title">
			   	  <h4>猜你喜欢</h4>
			   </div>


			   <!-- 娱乐列表 -->
			   <div class="product-list clearfix">
			   			
			   		<!-- 左侧盒子 -->
			   	    <div class="l-list">

			   	    	  <div class="public-box">
			   	    	  		
			   	    	  	   <!-- 左侧盒子显示图片 -->
			   	    	  	   <div class="l-pub-box">
			   	    	  	   	   <div class="top-img">
			   	    	  	   	   	 <img src="images/01.png" alt="">
			   	    	  	   	   </div>
			   	    	  	   </div>

							    <!-- 右侧盒子显示内容 -->
			   	    	  	   <div class="r-pub-box">
			   	    	  	   	   <p class="p1">范冰冰</p>
			   	    	  	   	   <p class="p2">
			   	    	  	   	   	将要和李晨结婚，机场牵手晒幸福
			   	    	            
								   </p>
			   	    	  	   </div>
			   	    	  </div>

			   	    	  <div class="public-box">
			   	    	  		
			   	    	  	   <!-- 左侧盒子显示图片 -->
			   	    	  	   <div class="l-pub-box">
			   	    	  	   	   <div class="top-img">
			   	    	  	   	   	 <img src="images/01.png"  alt="">
			   	    	  	   	   </div>

			   	    	  	   </div>

							    <!-- 右侧盒子显示内容 -->
			   	    	  	   <div class="r-pub-box">
			   	    	  	   	   <p class="p1">范冰冰</p>
			   	    	  	   	   <p class="p2">
			   	    	  	   	   	将要和李晨结婚，机场牵手晒幸福
			   	    	  	   	   	 
								   </p>
			   	    	  	   </div>
			   	    	  </div>
			   	    	 
			   	    	  <div class="line"></div>

			   	    	  <div class="public-box">
			   	    	  		
			   	    	  	   <!-- 左侧盒子显示图片 -->
			   	    	  	   <div class="l-pub-box">
			   	    	  	   	   <div class="top-img">
			   	    	  	   	   	 <img src="images/01.png" alt="">
			   	    	  	   	   </div>

			   	    	  	   </div>

							    <!-- 右侧盒子显示内容 -->
			   	    	  	   <div class="r-pub-box">
			   	    	  	   	   <p class="p1">范冰冰</p>
			   	    	  	   	   <p class="p2">
			   	    	  	   	   	将要和李晨结婚，机场牵手晒幸福 
			   	    	  	   	   	 
								   </p>
			   	    	  	   </div>
			   	    	  </div>

			   	    	  <div class="public-box">
			   	    	  		
			   	    	  	   <!-- 左侧盒子显示图片 -->
			   	    	  	   <div class="l-pub-box">
			   	    	  	   	   <div class="top-img">
			   	    	  	   	   	 <img src="images/01.png"   alt="">
			   	    	  	   	   </div>

			   	    	  	   	   
			   	    	  	   </div>

							    <!-- 右侧盒子显示内容 -->
			   	    	  	   <div class="r-pub-box">
			   	    	  	   	   <p class="p1">范冰冰</p>
			   	    	  	   	   <p class="p2">
			   	    	  	   	   将要和李晨结婚，机场牵手晒幸福
			   	    	  	   	   	 
								   </p>
								   
			   	    	  	   </div>
			   	    	  </div>
			   	    </div>
					
					<!-- 右侧盒子 -->
			   	    <div class="r-list">
			   	    	
			   	    	 <div class="r-title">
			   	    	 	 <h4>娱乐圈那些事</h4>
			   	    	 </div>

			   	    	 <div class="content">
			   	    	 	 <ul>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 	<li><a href="#">陈思成深夜出轨两女人</a></li>
			   	    	 	 </ul>
			   	    	 </div>
			   	    </div>
			   </div>

			   <!-- 国家大事 -->
			   <div class="public-title">
			   	  <h4>国家大事</h4>
			   </div>

			   <!-- 列表 -->

			   <div class="child-list clearfix">
			   	 	
			   	 	 <!-- 左侧列表 -->
			   	 	 <div class="l-child">
			   	 	 	
			   	 	 	  <div class="top-imgs">
			   	 	 	  	  

			   	 	 	  	  <a href="#">详情请点击>></a>
			   	 	 	  </div>

						  <!-- 下面图片展示 -->
			   	 	 	  <div class="bot-product">
			   	 	 	  		
			   	 	 	  		<div class="pub-box">
			   	 	 	  			
			   	 	 	  			 <img src="images/01.png">
			   	 	 	  			 <p class="p1">
			   	 	 	  			 	<a href="#">
			   	 	 	  			 	习大大和彭大娘出使美国</a>
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p2">
			   	 	 	  			 	去哪玩
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p3">
			   	 	 	  			 	吃的啥
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p4">
			   	 	 	  			 	你怎么看
			   	 	 	  			 </p>
			   	 	 	  		</div>
			   	 	 	  		<div class="pub-box">
			   	 	 	  			
			   	 	 	  			 <img src="images/01.png">
			   	 	 	  			 <p class="p1">
			   	 	 	  			 	<a href="#">
			   	 	 	  			 	习大大和彭大娘出使美国</a>
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p2">
			   	 	 	  			 	去哪玩
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p3">
			   	 	 	  			 	吃的啥
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p4">
			   	 	 	  			 	你怎么看
			   	 	 	  			 </p>
			   	 	 	  		</div>
			   	 	 	  		<div class="pub-box">
			   	 	 	  			
			   	 	 	  			 <img src="images/01.png">
			   	 	 	  			 <p class="p1">
			   	 	 	  			 	<a href="#">
			   	 	 	  			 	习大大和彭大娘出使美国</a>
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p2">
			   	 	 	  			 	去哪玩
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p3">
			   	 	 	  			 	吃的啥
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p4">
			   	 	 	  			 	你怎么看
			   	 	 	  			 </p>
			   	 	 	  		</div>
			   	 	 	  		<div class="pub-box">
			   	 	 	  			
			   	 	 	  			 <img src="images/01.png">
			   	 	 	  			 <p class="p1">
			   	 	 	  			 	<a href="#">
			   	 	 	  			 	习大大和彭大娘出使美国</a>
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p2">
			   	 	 	  			 	去哪玩
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p3">
			   	 	 	  			 	吃的啥
			   	 	 	  			 </p>

			   	 	 	  			 <p class="p4">
			   	 	 	  			 	你怎么看
			   	 	 	  			 </p>
			   	 	 	  		</div>
			   	 	 	  </div>
			   	 	 </div>
			   	 	 <!-- 右侧图片 -->
			   	 	 <div class="r-child">
			   	 	 	
			   	 	 	 <div class="top-l">
			   	 	 	 	 <div class="onel">
			   	 	 	 	 	<span>俄罗斯总理来访我国进一步
			   	 	 	 	 	促进两国的友好交往</span>
			   	 	 	 	 </div>
			   	 	 	 </div>

			   	 	 	 <div class="bot-l">
			   	 	 	 	 <div class="twol">
			   	 	 	 	 	<span>njsknbskcwbwonbcowabowa
			   	 	 	 	 	cnskvsvsvsvsvsvvcsdvsvsvwsvw
			   	 	 	 	 	dvsv</span>
			   	 	 	 	 </div>
			   	 	 	 </div>
			   	 	 </div>
			   </div>


			   <!-- 其他 -->
			   <div class="public-title">
			   	    <h4>其他</h4>
			   </div>

			   <div class="product-list clearfix">
			   			
			   		<!-- 左侧盒子 -->
			   	    <div class="l-list">

			   	    	  <div class="public-box">
			   	    	  		
			   	    	  	   <!-- 左侧盒子显示图片 -->
			   	    	  	   <div class="l-pub-box">
			   	    	  	   	   <div class="top-img">
			   	    	  	   	   	 <img src="images/01.png" alt="">
			   	    	  	   	   </div>

			   	    	  	   </div>

							    <!-- 右侧盒子显示内容 -->
			   	    	  	   <div class="r-pub-box">
			   	    	  	   	   <p class="p1">范冰冰</p>
			   	    	  	   	   <p class="p2">
			   	    	  	   	   将要和李晨结婚，机场牵手晒幸福
			   	    	  	   	   	 
								   </p>
			   	    	  	   </div>
			   	    	  </div>

			   	    	  <div class="public-box">
			   	    	  		
			   	    	  	   <!-- 左侧盒子显示图片 -->
			   	    	  	   <div class="l-pub-box">
			   	    	  	   	   <div class="top-img">
			   	    	  	   	   	 <img src="images/01.png" alt="">
			   	    	  	   	   </div>

			   	    	  	   	  
			   	    	  	   </div>

							    <!-- 右侧盒子显示内容 -->
			   	    	  	   <div class="r-pub-box">
			   	    	  	   	   <p class="p1">范冰冰</p>
			   	    	  	   	   <p class="p2">
			   	    	  	   	   将要和李晨结婚，机场牵手晒幸福
			   	    	  	   	   	 
								   </p>
			   	    	  	   </div>
			   	    	  </div>
			   	    	 
			   	    	  <div class="line"></div>

			   	    	  <div class="public-box">
			   	    	  		
			   	    	  	   <!-- 左侧盒子显示图片 -->
			   	    	  	   <div class="l-pub-box">
			   	    	  	   	   <div class="top-img">
			   	    	  	   	   	 <img src="images/01.png" alt="">
			   	    	  	   	   </div>

			   	    	  	   </div>

							    <!-- 右侧盒子显示内容 -->
			   	    	  	   <div class="r-pub-box">
			   	    	  	   	   <p class="p1">范冰冰</p>
			   	    	  	   	   <p class="p2">
			   	    	  	   	   将要和李晨结婚，机场牵手晒幸福
			   	    	  	   	   	 
								   </p>
			   	    	  	   </div>
			   	    	  </div>

			   	    	  <div class="public-box">
			   	    	  		
			   	    	  	   <!-- 左侧盒子显示图片 -->
			   	    	  	   <div class="l-pub-box">
			   	    	  	   	   <div class="top-img">
			   	    	  	   	   	 <img src="images/01.png"  alt="">
			   	    	  	   	   </div>

			   	    	  	   </div>

							    <!-- 右侧盒子显示内容 -->
			   	    	  	   <div class="r-pub-box">
			   	    	  	   	   <p class="p1">范冰冰</p>
			   	    	  	   	   <p class="p2">
			   	    	  	   	   将要和李晨结婚，机场牵手晒幸福
			   	    	  	   	   	 
								   </p>
			   	    	  	   </div>
			   	    	  </div>
			   	    </div>
					
					<!-- 右侧盒子 -->
			   	    <div class="r-list">
			   	    	
			   	    	 <div class="r-title">
			   	    	 	 <h4>随便写点</h4>
			   	    	 </div>

			   	    	 <div class="content">
							
							 <div class="subtitle">
							 	 
							 	 <p>
							 	 	
							 	 </p>
							 </div>

			   	    	 	 <ul>
			   	    	 	 	<li><a href="#">美食介绍类的也可以</a></li>
			   	    	 	 	<li><a href="#">美食介绍类的也可以</a></li>
			   	    	 	 	<li><a href="#">美食介绍类的也可以</a></li>
			   	    	 	 	<li><a href="#">美食介绍类的也可以</a></li>
			   	    	 	 	<li><a href="#">美食介绍类的也可以</a></li>
			   	    	 	 	<li><a href="#">美食介绍类的也可以</a></li>
			   	    	 	 	<li><a href="#">美食介绍类的也可以</a></li>
			   	    	 	 	<li><a href="#">美食介绍类的也可以</a></li>
			   	    	 	 </ul>
			   	    	 </div>
			   	    </div>
			   </div>

			   <!-- 结尾部分开始 -->

			   <div class="footer">
			   		
			   		 <div class="top">
			   		 	
			   		 	  <p>
			   		 	  	友情链接：
			   		 	  </p>

			   		 	  <ul>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	<li><a href="#">顾北的小网站</a></li>
			   		 	  	
			   		 	  </ul>
			   		 </div>

			   		 <div class="bot">
			   		 	
			   		 	 <p>
			   		 	    <a href="#">关于我们</a>|
			   		 	 	<a href="#">联系我们</a>|
			   		 	 	<a href="#">网站建设</a>|
			   		 	 	<a href="#">诚聘英才</a>|
			   		 	 	<a href="#">友情链接</a>|
			   		 	 	<a href="#">联系方式</a>|
			   		 	 	<a href="#">隐私声明</a>|
			   		 	 	<a href="#">版权声明</a>|
			   		 	 	<a href="#">帮助中心</a>|
			   		 	 	<a href="#">网站地图</a>
			   		 	 </p>
			   		 </div>
			   </div>
         </div>

    </body>
</html>






