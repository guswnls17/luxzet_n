var mainVisNum = 0 , rollNum;
var mainVisMax;
var curRoll = false;
var isRollMove = false;
var vInterval, mainVideo, videoPlay, vTime = 6000;
var _isHasScroll = false, _isScrollEnd = false, _isScrollStart = false;

$(document).ready(function(){
	//리사이즈
	$(window).resize(function(){
		$(".mainCon2 .swiper-container .swiper-slide .txtBox").css("width",$(".mainCon2 .swiper-container .swiper-slide").width());
	$(".mainCon4 .swiper-container .swiper-slide .txtBox").css("width",$(".mainCon4 .swiper-container .swiper-slide").width());

		if($(window).width() < 981){
			if($(window).height() > 700){
				$(".mainCon3 .careerDiv .rightD").css("height","140px");
				$(".mainCon3 .careerDiv").css("top","190px");
				$(".mainCon3 .careerDiv .leftD").css("top","150px");
				$(".mainCon3 .careerDiv .leftD .list").css("height","140px");
				$(".mainCon3 .txtDiv .txt1").css("top","87px");
				$(".mainCon3 .txtDiv .txt2").css("top","131px");

								$(".mainCon5 .careerDiv .leftD").css("height","140px");
				$(".mainCon5 .careerDiv").css("top","190px");
				$(".mainCon5 .careerDiv .rightD").css("top","150px");
				$(".mainCon5 .careerDiv .rightD .list").css("height","140px");
				$(".mainCon5 .txtDiv .txt1").css("top","87px");
				$(".mainCon5 .txtDiv .txt2").css("top","131px");
			}else if($(window).height() > 550){
				$(".mainCon3 .careerDiv .leftD .list").css("height","100px");
				$(".mainCon5 .careerDiv .rightD .list").css("height","100px");
			}
		}

		if($(window).width() > 1230){
			$(".mainCon1 .listDiv .list1").css({"left":"0", "right":"auto", "top":"0"});
			$(".mainCon1 .listDiv .list2").css({"left":"295px", "top":"0"});
			$(".mainCon1 .listDiv .list3").css({"left":"590px","right":"auto", "top":"0"});
			$(".mainCon1 .listDiv .list4").css({"left":"885px", "top":"0"});
			$(".mainCon2 .swiper-container").css("top","430px");

						$(".mainCon4 .swiper-container").css("top","450px");

		}else if($(window).width() > 981){		
			$(".mainCon1 .txtDiv .txt1").css("top","87px");
			$(".mainCon1 .txtDiv .txt2").css("top","131px");
			$(".mainCon1 .txtDiv .txt3").css("top","161px");
			$(".mainCon1 .listDiv").css("top","240px");
			$(".mainCon1 .listDiv .list1").css({"left":"auto", "right":"50%"});
			$(".mainCon1 .listDiv .list2").css("left","50%");
			$(".mainCon1 .listDiv .list3").css({"left":"auto","right":"50%","top":"200px"});
			$(".mainCon1 .listDiv .list5").css({"left":"50%","top":"200px"});
			$(".mainCon2 .swiper-container").css("top","200px");

						$(".mainCon4 .swiper-container").css("top","200px");


			$(".mainCon3 .txtDiv .txt1").css("top","87px");
			$(".mainCon3 .txtDiv .txt2").css("top","131px");
			$(".mainCon3 .careerDiv .rightD").css("top","180px");
			$(".mainCon3 .careerDiv .leftD").css("height","160px");
			$(".mainCon3 .careerDiv .rightD .list").css("height","130px");

						$(".mainCon5 .txtDiv .txt1").css("top","87px");
			$(".mainCon5 .txtDiv .txt2").css("top","131px");
			$(".mainCon5 .careerDiv .rightD").css("top","180px");
			$(".mainCon5 .careerDiv .leftD").css("height","160px");
			$(".mainCon5 .careerDiv .rightD .list").css("height","130px");

		}else if($(window).width() > 850){
			if($(window).width() < $(window).height()){
				$(".mainCon3 .txtDiv .txt1").css("top","87px");
				$(".mainCon3 .txtDiv .txt2").css("top","131px");
								$(".mainCon5 .txtDiv .txt1").css("top","87px");
				$(".mainCon5 .txtDiv .txt2").css("top","131px");

				$(".mainCon1 .listDiv").css("top","20%");
				$(".mainCon1 .listDiv .list1").css({"left":"auto", "right":"50%"});
				$(".mainCon1 .listDiv .list2").css("left","50%");
				$(".mainCon1 .listDiv .list3").css({"left":"auto","right":"50%", "top":"152px"});
				$(".mainCon1 .listDiv .list4").css({"left":"50%","top":"152px"});
				$(".mainCon2 .swiper-container").css("top","20%");

								$(".mainCon4 .swiper-container").css("top","20%");


				$(".mainCon3 .careerDiv .leftD").css("height","120px");
				$(".mainCon3 .careerDiv .rightD").css("top","130px");
				$(".mainCon3 .careerDiv .rightD .list").css("height","100px");

								$(".mainCon5 .careerDiv .leftD").css("height","190px");
				$(".mainCon5 .careerDiv .rightD").css("top","200px");
				$(".mainCon5 .careerDiv .rightD .list").css("height","100px");

			}
		}else if($(window).width() > 480){
			if($(window).width() < $(window).height()){
				$(".mainCon1 .txt1").css("top","84px");
				$(".mainCon1 .txt2").css("top","128px");
				$(".mainCon1 .listDiv").css("top","270px");
				$(".mainCon1 .listDiv .list3").css("top","200px");
				$(".mainCon1 .listDiv .list4").css("top","200px");
				$(".mainCon1 .listDiv .list1").css({"left":"auto", "right":"50%"});
				$(".mainCon1 .listDiv .list2").css("left","50%");
				$(".mainCon1 .listDiv .list3").css({"left":"auto","right":"50%"});
				$(".mainCon1 .listDiv .list4").css("left","50%");
				$(".mainCon2 .swiper-container").css("top","130px");

								$(".mainCon4 .swiper-container").css("top","130px");

				$(".mainCon3 .careerDiv .rightD").css("height","190px");
				$(".mainCon3 .careerDiv").css("top","190px");
				$(".mainCon3 .careerDiv .leftD").css("top","210px");
				$(".mainCon3 .careerDiv .leftD .list").css("height","150px");

								$(".mainCon5 .careerDiv .leftD").css("height","190px");
				$(".mainCon5 .careerDiv").css("top","190px");
				$(".mainCon5 .careerDiv .rightD").css("top","210px");
				$(".mainCon5 .careerDiv .rightD .list").css("height","150px");

				$(".mainCon1 .listDiv .list1").css({"left":"auto", "right":"50%"});
				$(".mainCon1 .listDiv .list2").css("left","50%");
				$(".mainCon1 .listDiv .list3").css({"left":"auto","right":"50%"});
				$(".mainCon1 .listDiv .list4").css("left","50%");
				$(".mainCon3 .txtDiv .txt1").css("top","87px");
				$(".mainCon3 .txtDiv .txt2").css("top","131px");
							$(".mainCon3 .txtDiv .txt2").css("top","181px");

				$(".mainCon5 .txtDiv .txt1").css("top","87px");
				$(".mainCon5 .txtDiv .txt2").css("top","131px");
			}else{
				$(".mainCon1 .listDiv").css("top","30%");
				$(".mainCon1 .listDiv .list1").css({"left":"auto", "right":"50%"});
				$(".mainCon1 .listDiv .list2").css("left","50%");
				$(".mainCon1 .listDiv .list3").css({"left":"auto","right":"50%", "top":"152px"});
				$(".mainCon1 .listDiv .list4").css({"left":"50%","top":"152px"});
				$(".mainCon1 .txtDiv .txt1").css("top","87px");
				$(".mainCon1 .txtDiv .txt2").css("top","131px");
				$(".mainCon2 .txtDiv .txt1").css("top","87px");
				$(".mainCon2 .txtDiv .txt2").css("top","131px");

								$(".mainCon4 .txtDiv .txt1").css("top","87px");
				$(".mainCon4 .txtDiv .txt2").css("top","131px");


				$(".mainCon3 .txtDiv .txt1").css("top","87px");
				$(".mainCon3 .txtDiv .txt2").css("top","131px");
				$(".mainCon3 .careerDiv").css("top","160px");
				$(".mainCon3 .careerDiv .leftD").css("height","120px");
				$(".mainCon3 .careerDiv .rightD").css("top","130px");
				$(".mainCon3 .careerDiv .rightD .list").css("height","100px");

								$(".mainCon5 .txtDiv .txt1").css("top","87px");
				$(".mainCon5 .txtDiv .txt2").css("top","131px");
				$(".mainCon5 .careerDiv").css("top","160px");
				$(".mainCon5 .careerDiv .leftD").css("height","190px");
				$(".mainCon5 .careerDiv .rightD").css("top","200px");
				$(".mainCon5 .careerDiv .rightD .list").css("height","100px");
			}
		}else{
			if($(window).height() > 490){
				$(".mainCon1 .listDiv").css("top","30%");
				$(".mainCon1 .listDiv .list1").css({"left":"auto", "right":"50%"});
				$(".mainCon1 .listDiv .list2").css("left","50%");
				$(".mainCon1 .listDiv .list3").css({"left":"auto","right":"50%", "top":"122px"});
				$(".mainCon1 .listDiv .list4").css({"left":"50%","top":"122px"});
				$(".mainCon3 .careerDiv .rightD").css("height","120px");
				$(".mainCon3 .careerDiv .leftD").css("top","130px");
				$(".mainCon3 .careerDiv .leftD .list").css("height","100px");
								$(".mainCon5 .careerDiv .leftD").css("height","150px");
				$(".mainCon5 .careerDiv .rightD").css("top","160px");
				$(".mainCon5 .careerDiv .rightD .list").css("height","100px");

				$(".mainCon1 .txtDiv .txt1").css("top","87px");
				$(".mainCon1 .txtDiv .txt2").css("top","131px");
				$(".mainCon2 .txtDiv .txt1").css("top","87px");
				$(".mainCon2 .txtDiv .txt2").css("top","131px");

								$(".mainCon4 .txtDiv .txt1").css("top","87px");
				$(".mainCon4 .txtDiv .txt2").css("top","131px");


				$(".mainCon3 .txtDiv .txt1").css("top","87px");
				$(".mainCon3 .txtDiv .txt2").css("top","131px");
								$(".mainCon5 .txtDiv .txt1").css("top","87px");
				$(".mainCon5 .txtDiv .txt2").css("top","131px");

				$(".mainCon2 .swiper-container").css("top","20%");
				$(".mainCon3 .careerDiv").css("top","160px");
					$(".mainCon5 .careerDiv").css("top","160px");
			}else{
				$(".mainCon1 .txtDiv .txt1").css("top","45px");
				$(".mainCon1 .txtDiv .txt2").css("top","100px");
			    $(".mainCon1 .txtDiv .txt2").css("top","150px");
				$(".mainCon2 .txtDiv .txt1").css("top","45px");
				$(".mainCon2 .txtDiv .txt2").css("top","100px");

								$(".mainCon4 .txtDiv .txt1").css("top","45px");
				$(".mainCon4 .txtDiv .txt2").css("top","100px");


				$(".mainCon3 .txtDiv .txt1").css("top","45px");
				$(".mainCon3 .txtDiv .txt2").css("top","100px");
								$(".mainCon5 .txtDiv .txt1").css("top","45px");
				$(".mainCon5 .txtDiv .txt2").css("top","100px");
				$(".mainCon2 .swiper-container").css("top","27%");

								$(".mainCon4 .swiper-container").css("top","20%");

				$(".mainCon3 .careerDiv").css("top","135px");
				                $(".mainCon5 .careerDiv").css("top","135px");
			}
		}

		/*
		if($(window).width() > 1230){
			
		}else if($(window).width() < 1230){
			$(".mainCon3 .careerDiv .leftD").css("height","180px");
			$(".mainCon3 .careerDiv").css("top","200px");
			$(".mainCon3 .careerDiv .rightD").css("top","200px");
			$(".mainCon3 .careerDiv .rightD .list").css("height","150px");
			$(".mainCon3 .txtDiv .txt1").css("top","87px");
			$(".mainCon3 .txtDiv .txt2").css("top","131px");
			$(".mainCon1 .txtDiv .txt1").css("top","84px");
			$(".mainCon1 .txtDiv .txt2").css("top","128px");
			$(".mainCon1 .listDiv .list3").css("top","230px");
			$(".mainCon1 .listDiv .list4").css("top","230px");
		}else if($(window).width() < 964) {
			
		}else{
			$(".mainCon3 .careerDiv .leftD").css("height","360px");
			$(".mainCon3 .careerDiv .rightD").css("top","0");
			$(".mainCon3 .careerDiv .rightD .list").css("height","140px");
		}*/
	}); $(window).resize();

	//뉴스리스트
	var newsNum = 1;
	var maxNewsNum = $(".mainCon2 .swiper-container .swiper-slide").size();
	if(maxNewsNum > 9){
		$(".mainCon2 .swiper-container .paging > p.maxNum").text(maxNewsNum-3);
	}else{
		$(".mainCon2 .swiper-container .paging > p.maxNum").text("0"+(maxNewsNum-3));
	}


	var mainSwiper = new Swiper('.main-swiper',{
		loop: false,
		pagination: {
			el: '.swiper-pagination',
			clickable:true
		}
	});

	//메인레이어팝업
	/*var mPopSwiper = new Swiper('.layerPop-container',{
		pagination: {
			el: '.swiper-pagination',
			clickable:true
		},
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		}, on: {
		slideChange: function(){
		  if(this.isEnd){
			this.navigation.$nextEl.css('display','block');
		  }else{
			this.navigation.$nextEl.css('display','block');  
		  }
		},
	  },
	});
	
	if($(".mainLayerPop .swiper-slide").size() < 2){
		$(".mainLayerPop .swiper-button-next").hide();
		$(".mainLayerPop .swiper-button-prev").hide();
	}

	$(".mainLayerPop .swiper-slide .text").mCustomScrollbar();
	*/

	$(".mainLayerPop .popBottom .xBt").click(function(){
		$(".blackBg").fadeOut(300);
		$(".mainLayerPop").fadeOut(300);
	});
	
/*
	var newsList = new Swiper('.swiper-container', {
		slidesPerView: 6,
		spaceBetween: 20,
		pagination: {
			el: '.swiper-pagination',
			type: 'progressbar',
		},
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},
		on: {
			init: function () {
				console.log("swiper initialization");
			},
			slideChangeTransitionStart: function(){
				
			},
			slideChangeTransitionEnd: function(){
				newsNum++;
				$(".mainCon2 .swiper-container .paging > p.num").text("0"+newsNum);
				//TweenMax.to($(".mainVisArea .swiper-wrapper .swiper-slide").not(".swiper-slide-active").find(".txtBox"), 0, {top:180, opacity:0, ease:Power3.easeOut});
				//TweenMax.to($(".mainVisArea .swiper-wrapper .swiper-slide.swiper-slide-active .txtBox"), 1.5, {top:80, opacity:1, ease:Power3.easeOut});
			},
			imagesReady: function(){
				//TweenMax.fromTo($(".mainVisArea .swiper-wrapper .swiper-slide.swiper-slide-active .txtBox"), 1.5, { top:180, opacity:0 }, { top:80, opacity:1, ease:Power3.easeOut});
			}
		}
    });
*/

/*
	var newsList = new Swiper('.swiper-container', {
		slidesPerView: 1, 
		spaceBetween: 20,
		slidesPerGroup: 6,
		loop: false,
		spaceBetween: 20,
		loopFillGroupWithBlank: true,
		scrollbar: {
			el: '.swiper-scrollbar',
			hide: false,
		},
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},
		pagination:{
			el:'.swiper-pagination',
			type:'bullets',
			clickable:true
		},
		breakpoints: {
			1230:{
				slidesPerView: "auto",
				slidesPerGroup: 1,
				spaceBetween: 15,
				centeredSlides: true
			}
		}
	});

	$(window).scroll(function(){
		scrollStarEndChk();
	});$(window).scroll();
*/

	/*
	//모바일 버튼
	$(".mobileBtn a").each(function(index){
		$(this).click(function(){
			if(!isWheelMove){
				if(!index){
					//위
					if(curWheel == 1){
						isWheelMove = true;
						TweenMax.to($(".mainVisDiv"), 0, {'top' : '-100%', ease:Power2.easeInOut});
						TweenMax.to($(".mainVisDiv"), 1, {'top' : '0', ease:Power2.easeInOut});
						$(".mainIndi li").removeClass("on");
						$(".mainIndi li").eq(curWheel-1).addClass("on");
						if($(window).width() < 1200){
							$(".mobileBtn").hide();
						}
						TweenMax.to($(".mainCon1"), 1, {'top' : '100%', ease:Power2.easeInOut, onComplete:function(){
							curWheel = 0;
							curWheel2 = 0;
							isWheelMove = false;
							$(".scrollBt").show();
						}});
					}else if(curWheel == 2){
						isWheelMove = true;
						
						TweenMax.to($(".mainCon1"), 0, {'top' : '-100%', ease:Power2.easeInOut});
						TweenMax.to($(".mainCon1"), 1, {'top' : '0', ease:Power2.easeInOut});
						$(".mainIndi li").removeClass("on");
						$(".mainIndi li").eq(curWheel-1).addClass("on");

						$(".mainIndi").removeClass("type2")
						$("#headerW").removeClass("type2")
						TweenMax.to($(".mainCon2"), 1, {'top' : '100%', ease:Power2.easeInOut, onComplete:function(){
							curWheel = 1;
							curWheel2 = 1;
							isWheelMove = false;
						}});
					}else if(curWheel == 3){
						isWheelMove = true;

						TweenMax.to($(".mainCon2"), 0, {'top' : '-100%', ease:Power2.easeInOut});
						TweenMax.to($(".mainCon2"), 1, {'top' : '0', ease:Power2.easeInOut});
						$(".mainIndi li").removeClass("on");
						$(".mainIndi li").eq(curWheel-1).addClass("on");
						$("#headerW").removeClass("type3")

						TweenMax.to($(".mainCon3"), 1, {'top' : '100%', ease:Power2.easeInOut, onComplete:function(){
							curWheel = 2;
							curWheel2 = 2;
							isWheelMove = false;
						}});
					}else if(curWheel == 4){
						isWheelMove = true;

						TweenMax.to($(".mainCon3"), 1, {'top' : '-100%', ease:Power2.easeInOut});
						TweenMax.to($(".mainCon3"), .5, {'top' : '0', ease:Power2.easeOut});
						TweenMax.to($(".mobileBtn"), .5, {'bottom' : '15', ease:Power2.easeOut});
						TweenMax.to($(".mobileBtn .next"), .5, {'opacity':'1','display' : 'block', ease:Power2.easeOut});
						if($(window).width() > 964){
							TweenMax.to($("#footer"), .5, {'bottom' : '-203', ease:Power2.easeOut, onComplete:function(){
								curWheel = 3;
								curWheel2 = 3;
								isWheelMove = false;
							}});
						}else{
							TweenMax.to($("#footer"), .5, {'bottom' : '-235', ease:Power2.easeOut, onComplete:function(){
								curWheel = 3;
								curWheel2 = 3;
								isWheelMove = false;
							}});
						}
					}
				}else{
					//아래
					setTimeout(function(){
						if(curWheel == 0){
							isWheelMove = true;
							TweenMax.to($(".mainVisDiv"), 1, {'top' : '-100%', ease:Power3.easeOut});
							$(".mainIndi li").removeClass("on");
							$(".mainIndi li").eq(curWheel+1).addClass("on");
							if($(window).width() < 1200){
								$(".mobileBtn").show();
							}
							TweenMax.to($(".mainCon1"), 0, {'top' : '100%', ease:Power3.easeOut});
							console.log("a")
							TweenMax.to($(".mainCon1"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
								curWheel = 1;
								curWheel2 = 1;
								isWheelMove = false;
							}});
							$(window).scrollTop(0);
						}else if(curWheel == 1){
							isWheelMove = true;

							TweenMax.to($(".mainCon1"), 1, {'top' : '-100%', ease:Power3.easeOut});
							$(".mainIndi li").removeClass("on");
							$(".mainIndi li").eq(curWheel+1).addClass("on");
							$(".mainIndi").addClass("type2");
							$("#headerW").addClass("type2")
							TweenMax.to($(".mainCon2"), 0, {'top' : '100%', ease:Power3.easeOut});
							TweenMax.to($(".mainCon2"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
								curWheel = 2;
								curWheel2 = 2;
								isWheelMove = false;
							}});
							$(window).scrollTop(0);
						}else if(curWheel == 2){
							isWheelMove = true;

							TweenMax.to($(".mainCon2"), 1, {'top' : '-100%', ease:Power3.easeOut});
							$(".mainIndi li").removeClass("on");
							$(".mainIndi li").eq(curWheel+1).addClass("on");
							$("#headerW").addClass("type3")

							TweenMax.to($(".mainCon3"), 0, {'top' : '100%', ease:Power3.easeOut});
							TweenMax.to($(".mainCon3"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
								curWheel = 3;
								curWheel2 = 3;
								isWheelMove = false;
							}});
							$(window).scrollTop(0);
						}else if(curWheel == 3){
							isWheelMove = true;

							TweenMax.to($(".mainCon3"), .5, {'top' : '-203', ease:Power2.easeOut});
							TweenMax.to($(".mobileBtn"), .5, {'bottom' : '210', ease:Power2.easeOut});
							TweenMax.to($(".mobileBtn .next"), .5, {'opacity' : '0', 'display':'none', ease:Power2.easeOut});
							TweenMax.to($("#footer"), .5, {'bottom' : '0', ease:Power2.easeOut, onComplete:function(){
								curWheel = 4;
								curWheel2 = 4;
								isWheelMove = false;
							}});
							
						}
					},100);
				}
			}
		});
	});
	*/


	// 원페이지 스크롤
	var curWheel = 0;
	var curWheel2 = 0;
	var isWheelMove = false;
	
	$("#wrap.main").on('mousewheel DOMMouseScroll', function(e) {
		if($(window).width() > 1230){
			if(isWheelMove == false){
				var E = e.originalEvent;
				delta = 0;
				if (E.detail) { //익스, 파폭
					delta = E.detail * -40;

					if(delta == 120){
						//$('body').text("위로");
						if(_isHasScroll && _isScrollStart){
							setTimeout(function(){
								if(curWheel == 1){
									isWheelMove = true;								
									TweenMax.to($(".mainVisDiv"), 0, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainVisDiv"), 0.9, {'top' : '0', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel-1).addClass("on");
									$(".mobileBtn").hide();
									TweenMax.to($(".mainCon1"), 1.2, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
										curWheel = 0;
										curWheel2 = 0;
										isWheelMove = false;
										$(".scrollBt").show();
									}});

								}else if(curWheel == 2){
									isWheelMove = true;						
									TweenMax.to($(".mainCon1"), 0, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon1"), 0.9, {'top' : '0', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel-1).addClass("on");
									if($(window).width() > 1230){
										mainCon1_start()
										mainCon1();
									}
									$(".mainIndi").removeClass("type2")
									$("#headerW").removeClass("type2")
									TweenMax.to($(".mainCon2"), 1.2, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
										curWheel = 1;
										curWheel2 = 1;
										isWheelMove = false;
									}});

								}else if(curWheel == 3){
									isWheelMove = true;

									TweenMax.to($(".mainCon2"), 0, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon2"), 0.9, {'top' : '0', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel-1).addClass("on");
									$("#headerW").removeClass("type3")
									if($(window).width() > 1230){
										mainCon2_start();
										mainCon2();
									}
									TweenMax.to($(".mainCon3"), 1.2, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
										curWheel = 2;
										curWheel2 = 2;
										isWheelMove = false;
									}});

								}else if(curWheel == 4){
									isWheelMove = true;

									TweenMax.to($(".mainCon3"), 0, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon3"), 0.9, {'top' : '0', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel-1).addClass("on");
									$("#headerW").removeClass("type4")
									if($(window).width() > 1230){
										mainCon3_start();
										mainCon3();
									}
									TweenMax.to($(".mainCon3"), 1.2, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
										curWheel = 3;
										curWheel2 = 3;
										isWheelMove = false;
									}});

								}else if(curWheel == 5){
									isWheelMove = true;

									TweenMax.to($(".mainCon4"), 1, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon4"), .5, {'top' : '0', ease:Power3.easeOut});
									TweenMax.to($(".mobileBtn"), .5, {'bottom' : '15', ease:Power3.easeOut});
									TweenMax.to($(".mobileBtn .next"), .5, {'opacity' : '1', 'display':'block', ease:Power3.easeOut});
									if($(window).width() > 964){
										TweenMax.to($("#footer"), .5, {'bottom' : '-203', ease:Power3.easeOut, onComplete:function(){
											curWheel = 4;
											curWheel2 = 4;
											isWheelMove = false;
										}});

									}else{
										TweenMax.to($("#footer"), .5, {'bottom' : '-235', ease:Power3.easeOut, onComplete:function(){
											curWheel = 5;
											curWheel2 = 5;
											isWheelMove = false;
										}});
									}
								}
							}, 100);
						}else if(!_isHasScroll){
							if(curWheel == 1){
								isWheelMove = true;
								
								TweenMax.to($(".mainVisDiv"), 0, {'top' : '-100%', ease:Power3.easeOut});
								TweenMax.to($(".mainVisDiv"), 1, {'top' : '0', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel-1).addClass("on");
								$(".mobileBtn").hide();
								TweenMax.to($(".mainCon1"), 1, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
									curWheel = 0;
									curWheel2 = 0;
									isWheelMove = false;
								}});
							}else if(curWheel == 2){
								isWheelMove = true;
								
								TweenMax.to($(".mainCon1"), 0, {'top' : '-100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon1"), 1, {'top' : '0', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel-1).addClass("on");
								if($(window).width() > 1230){
									mainCon1_start()
									mainCon1();
								}
								$(".mainIndi").removeClass("type2")
								$("#headerW").removeClass("type2")
								TweenMax.to($(".mainCon2"), 1, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
									curWheel = 1;
									curWheel2 = 1;
									isWheelMove = false;
								}});
							}else if(curWheel == 3){
								isWheelMove = true;

								TweenMax.to($(".mainCon2"), 0, {'top' : '-100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon2"), 1, {'top' : '0', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel-1).addClass("on");
								$("#headerW").removeClass("type3")
								if($(window).width() > 1230){
									mainCon2_start();
									mainCon2();
								}
								TweenMax.to($(".mainCon3"), 1, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
									curWheel = 2;
									curWheel2 = 2;
									isWheelMove = false;
								}});
	
								}else if(curWheel == 4){
								isWheelMove = true;
								
								TweenMax.to($(".mainCon3"), 0, {'top' : '-100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon3"), 1, {'top' : '0', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel-1).addClass("on");
								if($(window).width() > 1230){
									mainCon3_start()
									mainCon3();
								}
								$(".mainIndi").removeClass("type4")
								$("#headerW").removeClass("type4")
								TweenMax.to($(".mainCon3"), 1, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
									curWheel = 3;
									curWheel2 = 3;
									isWheelMove = false;
								}});

							}else if(curWheel == 5){
								isWheelMove = true;

								TweenMax.to($(".mainCon4"), 1, {'top' : '-100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon4"), .5, {'top' : '0', ease:Power3.easeOut});
								TweenMax.to($(".mobileBtn"), .5, {'bottom' : '15', ease:Power3.easeOut});
								TweenMax.to($(".mobileBtn .next"), .5, {'opacity' : '1', 'display':'block', ease:Power3.easeOut});
								TweenMax.to($("#footer"), .5, {'bottom' : '-203', ease:Power3.easeOut, onComplete:function(){
									curWheel = 4;
									curWheel2 = 4;
									isWheelMove = false;
								}});
								
							}
						}
					}else if(delta == -120){
						//$('body').text("아래로");
						if(_isHasScroll && _isScrollEnd){
							setTimeout(function(){
								if(curWheel == 0){
									isWheelMove = true;
									TweenMax.to($(".mainVisDiv"), 1.2, {'top' : '-_mainWrapH%', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel+1).addClass("on");
									if($(window).width() > 1230){
										mainCon1_start();
										mainCon1();
									}else{
										$(".mobileBtn").show();
									}
									$(".scrollBt").hide();
									TweenMax.to($(".mainCon1"), 0, {'top' : '100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon1"), 0.9, {'top' : '0', ease:Power3.easeOut, onComplete:function(){

										curWheel = 1;
										curWheel2 = 1;
										isWheelMove = false;
									}});
									$(window).scrollTop(0);
								}else if(curWheel == 1){
									isWheelMove = true;

									TweenMax.to($(".mainCon1"), 1.2, {'top' : '-100%', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel+1).addClass("on");
									if($(window).width() > 1230){
										mainCon2_start();
										mainCon2();
									}
									$(".mainIndi").addClass("type2");
									$("#headerW").addClass("type2")
									TweenMax.to($(".mainCon2"), 0, {'top' : '100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon2"), 0.9, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
										curWheel = 2;
										curWheel2 = 2;
										isWheelMove = false;
									}});
									$(window).scrollTop(0);
								}else if(curWheel == 2){
									isWheelMove = true;

									TweenMax.to($(".mainCon2"), 1.2, {'top' : '-100%', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel+1).addClass("on");
									$("#headerW").addClass("type2")
									if($(window).width() > 1230){
										mainCon3_start();
										mainCon3();
									}
									TweenMax.to($(".mainCon3"), 0, {'top' : '100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon3"), 0.9, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
										curWheel = 3;
										curWheel2 = 3;
										isWheelMove = false;
									}});
									$(window).scrollTop(0);

								}else if(curWheel == 3){
									isWheelMove = true;

									TweenMax.to($(".mainCon3"), 1.2, {'top' : '-100%', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel+1).addClass("on");
									if($(window).width() > 1230){
										mainCon4_start();
										mainCon4();
									}
									$(".mainIndi").addClass("type4");
									$("#headerW").addClass("type4")
									TweenMax.to($(".mainCon3"), 0, {'top' : '100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon3"), 0.9, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
										curWheel = 4;
										curWheel2 = 4;
										isWheelMove = false;
									}});
									$(window).scrollTop(0);

								}else if(curWheel == 4){
									isWheelMove = true;
									TweenMax.to($(".mainCon4"), .5, {'top' : '-203', ease:Power3.easeOut});
									TweenMax.to($(".mobileBtn"), .5, {'bottom' : '210', ease:Power3.easeOut});
									TweenMax.to($(".mobileBtn .next"), .5, {'opacity' : '0', 'display':'none', ease:Power3.easeOut});
									TweenMax.to($("#footer"), .5, {'bottom' : '0', ease:Power3.easeOut, onComplete:function(){
										curWheel = 5;
										curWheel2 = 5;
										isWheelMove = false;
									}});
								}
							},100);
						}else if(!_isHasScroll){
							if(curWheel == 0){
								isWheelMove = true;
								TweenMax.to($(".mainVisDiv"), 1, {'top' : '-100%', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel+1).addClass("on");
								if($(window).width() > 1230){
									mainCon1_start();
									mainCon1();
								}else{
									$(".mobileBtn").show();
								}
								TweenMax.to($(".mainCon1"), 0, {'top' : '100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon1"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){

									curWheel = 1;
									curWheel2 = 1;
									isWheelMove = false;
								}});
							}else if(curWheel == 1){
								isWheelMove = true;

								TweenMax.to($(".mainCon1"), 1, {'top' : '-100%', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel+1).addClass("on");
								if($(window).width() > 1230){
									mainCon2_start();
									mainCon2();
								}
								$(".mainIndi").addClass("type2");
								//$("#headerW").addClass("type2")
								TweenMax.to($(".mainCon2"), 0, {'top' : '100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon2"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
									curWheel = 2;
									curWheel2 = 2;
									isWheelMove = false;
								}});
							}else if(curWheel == 2){
								isWheelMove = true;

								TweenMax.to($(".mainCon2"), 1, {'top' : '-100%', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel+1).addClass("on");
								$("#headerW").addClass("type3")
								if($(window).width() > 1230){
									mainCon3_start();
									mainCon3();
								}
								TweenMax.to($(".mainCon3"), 0, {'top' : '100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon3"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
									curWheel = 3;
									curWheel2 = 3;
									isWheelMove = false;
								}});

															}else if(curWheel == 3){
								isWheelMove = true;

								TweenMax.to($(".mainCon3"), 1, {'top' : '-100%', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel+1).addClass("on");
								$("#headerW").addClass("type4")
								if($(window).width() > 1230){
									mainCon4_start();
									mainCon4();
								}
								TweenMax.to($(".mainCon4"), 0, {'top' : '100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon4"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
									curWheel = 4;
									curWheel2 = 4;
									isWheelMove = false;
								}});

							}else if(curWheel == 4){
								isWheelMove = true;
								TweenMax.to($(".mainCon4"), .5, {'top' : '-203', ease:Power3.easeOut});
								TweenMax.to($(".mobileBtn"), .5, {'bottom' : '210', ease:Power3.easeOut});
								TweenMax.to($(".mobileBtn .next"), .5, {'opacity' : '0', 'display':'none', ease:Power3.easeOut});
								TweenMax.to($("#footer"), .5, {'bottom' : '0', ease:Power3.easeOut, onComplete:function(){
									curWheel = 5;
									curWheel2 = 5;
									isWheelMove = false;
								}});
							}
						}
					}
				}else{ //크롬
					delta = E.wheelDelta;
					if(delta == 120){
						//$('body').text("마우스 위로 올릴때 필요 여기수정");
						if(_isHasScroll && _isScrollStart){
							setTimeout(function(){
								if(curWheel == 1){
									isWheelMove = true;
									
									TweenMax.to($(".mainVisDiv"), 0, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainVisDiv"), 0.9, {'top' : '0', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel-1).addClass("on");
									$(".mobileBtn").hide();
									TweenMax.to($(".mainCon1"), 1.2, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
										curWheel = 0;
										curWheel2 = 0;
										isWheelMove = false;
										$(".scrollBt").show();
									}});
								}else if(curWheel == 2){
									isWheelMove = true;
									
									TweenMax.to($(".mainCon2"), 0, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon1"), 0.9, {'top' : '0', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel-1).addClass("on");
									if($(window).width() > 1230){
										mainCon1_start()
										mainCon1();
									}
									$(".mainIndi").removeClass("type2")
									$("#headerW").removeClass("type2")
									TweenMax.to($(".mainCon2"), 1.2, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
										curWheel = 1;
										curWheel2 = 1;
										isWheelMove = false;
									}});
								
								}else if(curWheel == 3){
									isWheelMove = true;

									TweenMax.to($(".mainCon3"), 0, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon2"), 0.9, {'top' : '0', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel-1).addClass("on");
									//$("#headerW").removeClass("type3")
									if($(window).width() > 1230){
										mainCon2_start();
										mainCon2();
									}
									TweenMax.to($(".mainCon3"), 1.2, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
										curWheel = 2;
										curWheel2 = 2;
										isWheelMove = false;
									}});

								}else if(curWheel == 4){
									isWheelMove = true;

									TweenMax.to($(".mainCon3"), 0, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon3"), 0.9, {'top' : '0', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel-1).addClass("on");
									//$("#headerW").removeClass("type2")
									if($(window).width() > 1230){
										mainCon3_start();
										mainCon3();
									}
									TweenMax.to($(".mainCon3"), 1.2, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
										curWheel = 3;
										curWheel2 = 3;
										isWheelMove = false;
									}});

								}else if(curWheel == 5){
									isWheelMove = true;

									TweenMax.to($(".mainCon4"), 0, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon4"), 0.9, {'top' : '0', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel-1).addClass("on");
									//$("#headerW").removeClass("type2")
									if($(window).width() > 1230){
										mainCon4_start();
										mainCon4();
									}
									TweenMax.to($(".mainCon4"), 1.2, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
										curWheel = 4;
										curWheel2 = 4;
										isWheelMove = false;
									}});

								}else if(curWheel == 6){
									isWheelMove = true;

									TweenMax.to($(".mainCon5"), 1, {'top' : '-100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon5"), .5, {'top' : '0', ease:Power3.easeOut});
									TweenMax.to($(".mobileBtn"), .5, {'bottom' : '15', ease:Power3.easeOut});
									TweenMax.to($(".mobileBtn .next"), .5, {'opacity' : '1', 'display':'block', ease:Power3.easeOut});
									TweenMax.to($("#footer"), .5, {'bottom' : '-203', ease:Power3.easeOut, onComplete:function(){
										curWheel = 5;
										curWheel2 = 5;
										isWheelMove = false;
									}});
								}
							}, 100);
						}else if(!_isHasScroll){
							if(curWheel == 1){
								isWheelMove = true;
								
								TweenMax.to($(".mainVisDiv"), 0, {'top' : '-100%', ease:Power3.easeOut});
								TweenMax.to($(".mainVisDiv"), 1, {'top' : '0', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel-1).addClass("on");
								$(".mobileBtn").hide();
								TweenMax.to($(".mainCon1"), 1, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
									curWheel = 0;
									curWheel2 = 0;
									isWheelMove = false;
								}});
							}else if(curWheel == 2){
								isWheelMove = true;
								
								TweenMax.to($(".mainCon1"), 0, {'top' : '-100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon1"), 1, {'top' : '0', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel-1).addClass("on");
								if($(window).width() > 1230){
									mainCon1_start()
									mainCon1();
								}
								$(".mainIndi").removeClass("type2")
								$("#headerW").removeClass("type2")
								TweenMax.to($(".mainCon2"), 1, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
									curWheel = 1;
									curWheel2 = 1;
									isWheelMove = false;
								}});
							}else if(curWheel == 3){
								isWheelMove = true;
								
								TweenMax.to($(".mainCon2"), 0, {'top' : '-100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon2"), 1, {'top' : '0', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel-1).addClass("on");
								if($(window).width() > 1230){
									mainCon2_start()
									mainCon2();
								}
								$(".mainIndi").removeClass("type2")
								//$("#headerW").removeClass("type2")
								TweenMax.to($(".mainCon3"), 1, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
									curWheel = 2;
									curWheel2 = 2;
									isWheelMove = false;
								}});


							}else if(curWheel == 4){
								isWheelMove = true;
								
								TweenMax.to($(".mainCon3"), 0, {'top' : '-100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon3"), 1, {'top' : '0', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel-1).addClass("on");
								if($(window).width() > 1230){
									mainCon3_start()
									mainCon3();
								}
								$(".mainIndi").removeClass("type2")
								//$("#headerW").removeClass("type2")
								TweenMax.to($(".mainCon4"), 1, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
									curWheel = 3;
									curWheel2 = 3;
									isWheelMove = false;
								}});

							}else if(curWheel == 5){
								isWheelMove = true;
								
								TweenMax.to($(".mainCon4"), 0, {'top' : '-100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon4"), 1, {'top' : '0', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel-1).addClass("on");
								if($(window).width() > 1230){
									mainCon4_start()
									mainCon4();
								}
								$(".mainIndi").removeClass("type2")
								//$("#headerW").removeClass("type2")
								TweenMax.to($(".mainCon5"), 1, {'top' : '100%', ease:Power3.easeOut, onComplete:function(){
									curWheel = 4;
									curWheel2 = 4;
									isWheelMove = false;
								}});


							}else if(curWheel == 6){
								isWheelMove = true;

								TweenMax.to($(".mainCon5"), 1, {'top' : '-203', ease:Power3.easeOut});
								TweenMax.to($(".mainCon5"), .5, {'top' : '0', ease:Power3.easeOut});
								TweenMax.to($(".mobileBtn"), .5, {'bottom' : '15', ease:Power3.easeOut});
								TweenMax.to($(".mobileBtn .next"), .5, {'opacity' : '1', 'display':'block', ease:Power3.easeOut});
								TweenMax.to($("#footer"), .5, {'bottom' : '-203', ease:Power3.easeOut, onComplete:function(){
									curWheel = 5;
									curWheel2 = 5;
									isWheelMove = false;
								}});
							}
						}
					}else if(delta == -120){
						//$('body').text("마우스 아래로 내릴때 필요");
						if(_isHasScroll && _isScrollEnd){
							setTimeout(function(){
								if(curWheel == 0){
									isWheelMove = true;
									TweenMax.to($(".mainVisDiv"), 1.2, {'top' : -_mainWrapH, ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel+1).addClass("on");
									if($(window).width() > 1230){
										mainCon1_start();
										mainCon1();
									}else{
										$(".mobileBtn").show();
									}
									TweenMax.to($(".mainCon1"), 0, {'top' : _mainWrapH, ease:Power3.easeOut});
									TweenMax.to($(".mainCon1"), 0.9, {'top' : '0', ease:Power3.easeOut, onComplete:function(){

										curWheel = 1;
										curWheel2 = 1;
										isWheelMove = false;
									}});
									$(".scrollBt").hide();
									$(window).scrollTop(0);
								}else if(curWheel == 1){
									isWheelMove = true;

									TweenMax.to($(".mainCon1"), 1.2, {'top' : '-100%', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel+1).addClass("on");
									if($(window).width() > 1230){
										mainCon2_start();
										mainCon2();
									}
									$(".mainIndi").addClass("type2");
									$("#headerW").addClass("type2")
									TweenMax.to($(".mainCon2"), 0, {'top' : '100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon2"), 0.9, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
										curWheel = 2;
										curWheel2 = 2;
										isWheelMove = false;
									}});
									$(window).scrollTop(0);
								}else if(curWheel == 2){
									isWheelMove = true;

									TweenMax.to($(".mainCon2"), 1.2, {'top' : '-100%', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel+1).addClass("on");
									$("#headerW").addClass("type3")
									if($(window).width() > 1230){
										mainCon3_start();
										mainCon3();
									}
									TweenMax.to($(".mainCon3"), 0, {'top' : '100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon3"), 0.9, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
										curWheel = 3;
										curWheel2 = 3;
										isWheelMove = false;
									}});
									$(window).scrollTop(0);

																	}else if(curWheel == 3){
									isWheelMove = true;

									TweenMax.to($(".mainCon3"), 1.2, {'top' : '-100%', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel+1).addClass("on");
									//$("#headerW").addClass("type2")
									if($(window).width() > 1230){
										mainCon4_start();
										mainCon4();
									}
									TweenMax.to($(".mainCon4"), 0, {'top' : '100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon4"), 0.9, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
										curWheel = 4;
										curWheel2 = 4;
										isWheelMove = false;
									}});
									$(window).scrollTop(0);

																	}else if(curWheel == 4){
									isWheelMove = true;

									TweenMax.to($(".mainCon4"), 1.2, {'top' : '-100%', ease:Power3.easeOut});
									$(".mainIndi li").removeClass("on");
									$(".mainIndi li").eq(curWheel+1).addClass("on");
									//$("#headerW").addClass("type2")
									if($(window).width() > 1230){
										mainCon5_start();
										mainCon5();
									}
									TweenMax.to($(".mainCon5"), 0, {'top' : '100%', ease:Power3.easeOut});
									TweenMax.to($(".mainCon5"), 0.9, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
										curWheel = 5;
										curWheel2 = 5;
										isWheelMove = false;
									}});
									$(window).scrollTop(0);

								}else if(curWheel == 5){
									isWheelMove = true;
									TweenMax.to($(".mainCon5"), .5, {'top' : '-203', ease:Power3.easeOut});
									TweenMax.to($(".mobileBtn"), .5, {'bottom' : '210', ease:Power3.easeOut});
									TweenMax.to($(".mobileBtn .next"), .5, {'opacity' : '0', 'display':'none', ease:Power3.easeOut});
									TweenMax.to($("#footer"), .5, {'bottom' : '-203', ease:Power3.easeOut, onComplete:function(){
										curWheel = 6;
										curWheel2 = 6;
										isWheelMove = false;
									}});
								}
							},100);
						}else if(!_isHasScroll){
							if(curWheel == 0){
								isWheelMove = true;
								TweenMax.to($(".mainVisDiv"), 1, {'top' : '-100%', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel+1).addClass("on");
								if($(window).width() > 1230){
									mainCon1_start();
									mainCon1();
								}else{
									$(".mobileBtn").show();
								}
								TweenMax.to($(".mainCon1"), 0, {'top' : '100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon1"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){

									curWheel = 1;
									curWheel2 = 1;
									isWheelMove = false;
								}});
								$(".scrollBt").hide();
							}else if(curWheel == 1){
								isWheelMove = true;

								TweenMax.to($(".mainCon1"), 1, {'top' : '-100%', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel+1).addClass("on");
								if($(window).width() > 1230){
									mainCon2_start();
									mainCon2();
								}
								$(".mainIndi").addClass("type2");
								$("#headerW").addClass("type2")
								TweenMax.to($(".mainCon2"), 0, {'top' : '100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon2"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
									curWheel = 2;
									curWheel2 = 2;
									isWheelMove = false;
								}});
							}else if(curWheel == 2){
								isWheelMove = true;

								TweenMax.to($(".mainCon2"), 1, {'top' : '-100%', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel+1).addClass("on");
								$("#headerW").addClass("type3")
								if($(window).width() > 1230){
									mainCon3_start();
									mainCon3();
								}
																$(".mainIndi").addClass("type2");
								$("#headerW").addClass("type2")
								TweenMax.to($(".mainCon3"), 0, {'top' : '100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon3"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
									curWheel = 3;
									curWheel2 = 3;
									isWheelMove = false;
								}});

															}else if(curWheel == 3){
								isWheelMove = true;

								TweenMax.to($(".mainCon3"), 1, {'top' : '-100%', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel+1).addClass("on");
								$("#headerW").addClass("type3")
								if($(window).width() > 1230){
									mainCon4_start();
									mainCon4();
								}
																$(".mainIndi").addClass("type2");
								$("#headerW").addClass("type3")
								TweenMax.to($(".mainCon4"), 0, {'top' : '100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon4"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
									curWheel = 4;
									curWheel2 = 4;
									isWheelMove = false;
								}});

															}else if(curWheel == 4){
								isWheelMove = true;

								TweenMax.to($(".mainCon4"), 1, {'top' : '-100%', ease:Power3.easeOut});
								$(".mainIndi li").removeClass("on");
								$(".mainIndi li").eq(curWheel+1).addClass("on");
								//$("#headerW").addClass("type2")
								if($(window).width() > 1230){
									mainCon5_start();
									mainCon5();
								}
																$(".mainIndi").addClass("type2");
								$("#headerW").addClass("type2")
								TweenMax.to($(".mainCon5"), 0, {'top' : '100%', ease:Power3.easeOut});
								TweenMax.to($(".mainCon5"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
									curWheel = 5;
									curWheel2 = 5;
									isWheelMove = false;
								}});


							}else if(curWheel == 5){
								isWheelMove = true;
								TweenMax.to($(".mainCon5"), .5, {'top' : '-203', ease:Power3.easeOut});
								TweenMax.to($(".mobileBtn"), .5, {'bottom' : '210', ease:Power3.easeOut});
								TweenMax.to($(".mobileBtn .next"), .5, {'opacity' : '0', 'display':'none', ease:Power3.easeOut});
								TweenMax.to($("#footer"), .5, {'bottom' : '0', ease:Power3.easeOut, onComplete:function(){
									curWheel = 6;
									curWheel2 = 6;
									isWheelMove = false;
								}});
							}
						}
					}
				};
			}
		}

		//console.log(curWheel);
		//console.log(curWheel2);
	});
	
	
	/*
	//모바일 스크롤
	var prevY, nextY;
	$("#wrap.main").on('touchstart', function (e) {
		prevY = e.originalEvent.touches[0].clientY
	});
	$("#wrap.main").on("touchend", function(e){
		nextY = e.originalEvent.changedTouches[0].clientY
	});
	$("#wrap.main").on("touchmove", function(e){
		if(!isWheelMove){
			if(prevY > nextY + 30){
				console.log("아래")
				if(curWheel == 0){
					isWheelMove = true;

					TweenMax.to($(".mainVisDiv"), 1, {'top' : '-100%', ease:Power2.easeInOut});
					$(".mainIndi li").removeClass("on");
					$(".mainIndi li").eq(curWheel+1).addClass("on");
					if($(window).width() < 964){
						$(".mobileBtn").show();
					}
					TweenMax.to($(".mainCon1"), 0, {'top' : '100%', ease:Power2.easeInOut});
					TweenMax.to($(".mainCon1"), 1, {'top' : '0', ease:Power2.easeInOut, onComplete:function(){
						curWheel = 1;
						curWheel2 = 1;
						isWheelMove = false;
					}});
				}else if(curWheel == 1){
					isWheelMove = true;

					TweenMax.to($(".mainCon1"), 1, {'top' : '-100%', ease:Power2.easeInOut});
					$(".mainIndi li").removeClass("on");
					$(".mainIndi li").eq(curWheel+1).addClass("on");

					$(".mainIndi").addClass("type2");
					$("#headerW").addClass("type2")
					TweenMax.to($(".mainCon2"), 0, {'top' : '100%', ease:Power2.easeInOut});
					TweenMax.to($(".mainCon2"), 1, {'top' : '0', ease:Power2.easeInOut, onComplete:function(){
						curWheel = 2;
						curWheel2 = 2;
						isWheelMove = false;
					}});
				}else if(curWheel == 2){
					isWheelMove = true;

					TweenMax.to($(".mainCon2"), 1, {'top' : '-100%', ease:Power2.easeInOut});
					$(".mainIndi li").removeClass("on");
					$(".mainIndi li").eq(curWheel+1).addClass("on");
					$("#headerW").addClass("type3")

					TweenMax.to($(".mainCon3"), 0, {'top' : '100%', ease:Power2.easeInOut});
					TweenMax.to($(".mainCon3"), 1, {'top' : '0', ease:Power2.easeInOut, onComplete:function(){
						curWheel = 3;
						curWheel2 = 3;
						isWheelMove = false;
					}});
				}else if(curWheel == 3){
					isWheelMove = true;

					TweenMax.to($(".mainCon3"), .5, {'top' : '-255', ease:Power2.easeOut});
					TweenMax.to($("#footer"), .5, {'bottom' : '0', ease:Power2.easeOut, onComplete:function(){
						curWheel = 4;
						curWheel2 = 4;
						isWheelMove = false;
					}});
				}
			}else if(prevY < nextY - 30){
				console.log("위")
				if(curWheel == 1){
				isWheelMove = true;
				TweenMax.to($(".mainVisDiv"), 0, {'top' : '-100%', ease:Power2.easeInOut});
				TweenMax.to($(".mainVisDiv"), 1, {'top' : '0', ease:Power2.easeInOut});
				$(".mainIndi li").removeClass("on");
				$(".mainIndi li").eq(curWheel-1).addClass("on");
				if($(window).width() < 964){
					$(".mobileBtn").hide();
				}
				TweenMax.to($(".mainCon1"), 1, {'top' : '100%', ease:Power2.easeInOut, onComplete:function(){
					curWheel = 0;
					curWheel2 = 0;
					isWheelMove = false;
				}});
				}else if(curWheel == 2){
					isWheelMove = true;
					
					TweenMax.to($(".mainCon1"), 0, {'top' : '-100%', ease:Power2.easeInOut});
					TweenMax.to($(".mainCon1"), 1, {'top' : '0', ease:Power2.easeInOut});
					$(".mainIndi li").removeClass("on");
					$(".mainIndi li").eq(curWheel-1).addClass("on");

					$(".mainIndi").removeClass("type2")
					$("#headerW").removeClass("type2")
					TweenMax.to($(".mainCon2"), 1, {'top' : '100%', ease:Power2.easeInOut, onComplete:function(){
						curWheel = 1;
						curWheel2 = 1;
						isWheelMove = false;
					}});
				}else if(curWheel == 3){
					isWheelMove = true;

					TweenMax.to($(".mainCon2"), 0, {'top' : '-100%', ease:Power2.easeInOut});
					TweenMax.to($(".mainCon2"), 1, {'top' : '0', ease:Power2.easeInOut});
					$(".mainIndi li").removeClass("on");
					$(".mainIndi li").eq(curWheel-1).addClass("on");
					$("#headerW").removeClass("type3")

					TweenMax.to($(".mainCon3"), 1, {'top' : '100%', ease:Power2.easeInOut, onComplete:function(){
						curWheel = 2;
						curWheel2 = 2;
						isWheelMove = false;
					}});
				}else if(curWheel == 4){
					isWheelMove = true;

					TweenMax.to($(".mainCon3"), 1, {'top' : '-100%', ease:Power2.easeInOut});
					TweenMax.to($(".mainCon3"), .5, {'top' : '0', ease:Power2.easeOut});
					TweenMax.to($("#footer"), .5, {'bottom' : '-255', ease:Power2.easeOut, onComplete:function(){
						curWheel = 3;
						curWheel2 = 3;
						isWheelMove = false;
					}});
				}
			}
		}
	});
	*/

	//메인스크롤버튼
	$(".scrollBt a").click(function(){
		if(!isWheelMove){
			if($(window).width() > 1230){
				if(curWheel == 0){
					isWheelMove = true;
					TweenMax.to($(".mainVisDiv"), 1, {'top' : '-100%', ease:Power2.easeInOut});
					mainCon1_start()
					mainCon1();
					$(".mainIndi li").eq(0).removeClass("on");
					$(".mainIndi li").eq(1).addClass("on");
					$(".mainIndi").addClass("type2");
					TweenMax.to($(".mainCon1"), 1, {'top' : '0', ease:Power2.easeInOut, onComplete:function(){
						curWheel = 1;
						isWheelMove = false;
					}});
				}
			}else{
				isWheelMove = true;
				TweenMax.to($("html, body"), 1, {scrollTop:$(".mainSection").height(), ease:Power3.easeOut});
				TweenMax.to($(".mainVisDiv"), 1, {'top' : '-100%', ease:Power3.easeOut});
				TweenMax.to($(".mainCon1"), 1, {'top' : '0', ease:Power3.easeOut, onComplete:function(){
					curWheel = 1;
					isWheelMove = false;
				}});
				$(window).scrollTop(0);
			}
		}
	});

	//인디케이터
	$(".mainIndi li").each(function(q){
		$(this).find("a").click(function(){
			if(!isWheelMove){
				if(curWheel2 != q){
					if(curWheel2 > q){//올라올때
						if(curWheel2 == 6){
							if(q == 5){
								isWheelMove = true;
								TweenMax.to($(".mainCon5"), .5, {'top' : '0', ease:Power2.easeOut});
								TweenMax.to($("#footer"), 0.5, {'bottom' : '-203', ease:Power2.easeOut, onComplete:function(){
									isWheelMove = false;
								}});
								curWheel2 = q;
							}else{
								isWheelMove = true;
								TweenMax.to($(".mainSection").eq(5), 1, {'top' : '100%', ease:Power2.easeInOut});
								$(".mainIndi li").eq(5).removeClass("on");
								TweenMax.to($("#footer"), 1 , {'bottom' : '-203', ease:Power2.easeInOut});
								curWheel2 = q;
								$(".mainIndi li").eq(curWheel2).addClass("on");
								TweenMax.to($(".mainSection").eq(curWheel2), 0, {'top' : '-100%', ease:Power2.easeInOut});
								TweenMax.to($(".mainSection").eq(curWheel2), 1, {'top' : 0, ease:Power2.easeInOut, onComplete:function(){
									isWheelMove = false;
								}});
							}
						}else{
							isWheelMove = true;
							TweenMax.to($(".mainSection").eq(curWheel2), 1, {'top' : '100%', ease:Power2.easeInOut});
							$(".mainIndi li").eq(curWheel2).removeClass("on");
							curWheel2 = q;
							$(".mainIndi li").eq(curWheel2).addClass("on");
							TweenMax.to($(".mainSection").eq(curWheel2), 0, {'top' : '-100%', ease:Power2.easeInOut});
							TweenMax.to($(".mainSection").eq(curWheel2), 1, {'top' : 0, ease:Power2.easeInOut, onComplete:function(){
								isWheelMove = false;
							}});

							if(curWheel2 == 5){
								mainCon5_start()
								mainCon5();
							}
						}
						
						if(curWheel2 == 0){
							curWheel = 0;

							if($("#headerW").hasClass("type2")){
								$("#headerW").removeClass("type2")
							}
							if($("#headerW").hasClass("type3")){
								$("#headerW").removeClass("type3")
							}
						}else if(curWheel2 == 1){
							curWheel = 1;
							mainCon1_start();
							mainCon1();

							if($("#headerW").hasClass("type2")){
								$("#headerW").removeClass("type2")
							}
							if($("#headerW").hasClass("type3")){
								$("#headerW").removeClass("type3")
							}
						}else if(curWheel2 == 2){
							curWheel = 2;
							mainCon2_start();
							mainCon2();
							$(".mainIndi").removeClass("type2")

							if($("#headerW").hasClass("type3")){
								$("#headerW").removeClass("type3")
							}

														}else if(curWheel2 == 3){
							curWheel = 3;
							mainCon3_start();
							mainCon3();
							$(".mainIndi").removeClass("type2")

							if($("#headerW").hasClass("type3")){
								$("#headerW").removeClass("type3")
							}

						}else if(curWheel2 == 4){
							curWheel = 4;
														mainCon4_start();
							mainCon4();
							$(".mainIndi").removeClass("type2")

							if($("#headerW").hasClass("type2")){
								$("#headerW").removeClass("type2")
							}
	
						}else if(curWheel2 == 5){
							curWheel = 5;

						}else if(curWheel2 == 6){
							curWheel = 6;
						}
					}else if(curWheel2 < q){//내려올때
						isWheelMove = true;
						TweenMax.to($(".mainSection").eq(curWheel2), 1, {'top' : '-100%', ease:Power2.easeInOut});
						$(".mainIndi li").eq(curWheel2).removeClass("on");
						curWheel2 = q;
						$(".mainIndi li").eq(curWheel2).addClass("on");
						TweenMax.to($(".mainSection").eq(curWheel2), 0, {'top' : '100%', ease:Power2.easeInOut});
						TweenMax.to($(".mainSection").eq(curWheel2), 1, {'top' : 0, ease:Power2.easeInOut, onComplete:function(){
							isWheelMove = false;
						}});

						if(curWheel2 == 0){
							curWheel = 0;
						}else if(curWheel2 == 1){
							curWheel = 1;
							mainCon1_start()
							mainCon1();

						}else if(curWheel2 == 2){
							curWheel = 2;
							mainCon2_start()
							mainCon2();
							$(".mainIndi").addClass("type2")

							if(!$("#headerW").hasClass("type2")){
								$("#headerW").addClass("type2")
							}
						}else if(curWheel2 == 3){
							curWheel = 3;
							mainCon3_start()
							mainCon3();

							if(!$("#headerW").hasClass("type2")){
								$("#headerW").addClass("type2")
							}
							if(!$("#headerW").hasClass("type3")){
								$("#headerW").addClass("type3")
							}

						}else if(curWheel2 == 4){
							curWheel = 4;
							mainCon4_start()
							mainCon4();

							if(!$("#headerW").hasClass("type2")){
								$("#headerW").addClass("type2")
							}
							if(!$("#headerW").hasClass("type3")){
								$("#headerW").addClass("type3")
							}

						}else if(curWheel2 == 5){
							curWheel = 5;
							mainCon5_start()
							mainCon5();

							if(!$("#headerW").hasClass("type2")){
								$("#headerW").addClass("type2")
							}
							if(!$("#headerW").hasClass("type2")){
								$("#headerW").addClass("type2")
							}

						}else if(curWheel2 == 6){
							isWheelMove = true;

							TweenMax.to($(".mainCon5"), .5, {'top' : '-203', ease:Power2.easeOut});
							TweenMax.to($("#footer"), .5, {'bottom' : '0', ease:Power2.easeOut, onComplete:function(){
								curWheel = 6;
								curWheel2 = 6;
								isWheelMove = false;
							}});

							if(!$("#headerW").hasClass("type3")){
								$("#headerW").addClass("type3")
							}
							if(!$("#headerW").hasClass("type3")){
								$("#headerW").addClass("type3")
							}
						}
					}
				}
			}

			//console.log(curWheel);
			//console.log(curWheel2);
		})
	})

	//비쥬얼
	$(".playBt").click(function(){
		if(curRoll == false){ 
			/*
			clearInterval(rolling);*/
			clearInterval(vInterval);
			$(".playBt").find("img").attr("src", $(".playBt").find("img").attr("src").replace("stop", "play"));
			curRoll = true;
		}else if(curRoll == true){
			 clearInterval(vInterval);
			 vInterval = setInterval("rollingEvent()", vTime);
			 $(".playBt").find("img").attr("src", $(".playBt").find("img").attr("src").replace("play", "stop"));
			curRoll = false;
		}
	});
	
	
	/*
	var rolling = setInterval(function(){
		rollingEvent();
	},5000);*/

});

$(window).load(function(){
	visualH();
	$(window).resize(function(){
		scrollStarEndChk();
		if($(window).width() > 1230){
			$("#wBody").height(_mainWrapH);
			$("#wBody .mainSection").height(_mainWrapH);
		}else{
			$("#wrap").height("100%");
			$("#wBody").height("100%");
			$("#wBody .mainSection").height($(window).height());
		}
		if($(window).width() < 1230){
			if($(window).height() < 400){
				$("#wBody .mainSection").height($(window).width());
			}
		}

		$(".mainCon1 .listDiv .list").each(function(q){
			if($(window).width() > 1230){
				$(this).hover(function(){
					TweenMax.to($(".mainCon1 .listDiv .list").find(".off"), 0.7, {opacity:0.5, ease:Power3.easeOut});
					TweenMax.to($(this).find(".off"), 0.7, {opacity:0, ease:Power3.easeOut});
					TweenMax.to($(this).find(".on"), 0.7, {opacity:1, ease:Power3.easeOut});
					TweenMax.to($(".mainCon1 .bgDiv").find("div").eq(q), 0.7, {display:"block", opacity:1, ease:Power3.easeOut});
				}, function(){
					TweenMax.to($(".mainCon1 .listDiv .list").find(".off"), 0.7, {opacity:1, ease:Power3.easeOut});
					TweenMax.to($(this).find(".on"), 0.7, {opacity:0, ease:Power3.easeOut});
					TweenMax.to($(".mainCon1 .bgDiv").find("div").eq(q), 0.7, {display:"none", opacity:0, ease:Power3.easeOut});
				});
			}else{
				$(this).hover(function(){
					TweenMax.to($(".mainCon1 .listDiv .list").find(".off"), 0.7, {opacity:1, ease:Power3.easeOut});
					TweenMax.to($(this).find(".off"), 0, {opacity:1, ease:Power3.easeOut});
					TweenMax.to($(".mainCon1 .bgDiv").find("div").eq(q), 0.7, {display:"none", opacity:0, ease:Power3.easeOut});
				});
			}
		});
	});$(window).resize();
});

$(function(){
	// 메인비주얼
	mainVis();
	videoEvent();
	// technology hover
	
});


function mainVis(){
	TweenMax.to($(".mainVisDiv .visArea .visual").eq(0).find(".txtDiv .txt1").find("img"), 0.6, {top:0, delay:0.5, ease:Power4.easeOut});
	TweenMax.to($(".mainVisDiv .visArea .visual").eq(0).find(".txtDiv .txt2").find("img"), 0.6, {top:0, delay:0.9, ease:Power4.easeOut});
	TweenMax.to($(".mainVisDiv .visArea .visual").eq(0).find(".txtDiv .txt3"), 1.7, {top:265, opacity:1, delay:1.3, ease:Power4.easeOut, onComplte:function(){
		isRollMove = false;
	}});
	TweenMax.to($(".mainVisDiv .visBtn a").eq(0).find(".bar"), 2, {width:"100%", delay:0.5, ease:Power0.easeOut});
	mainVisMax = $(".mainVisDiv .visArea .visual").size()-1
	$(".mainVisDiv .visBtn a.rollBt").each(function(i){
		$(this).click(function(){
			if(mainVisNum != i){
				if(!isRollMove){
					isRollMove = true;
					$(".mainVisDiv .visBtn a.rollBt").eq(mainVisNum).removeClass("on");
					TweenMax.to($(".mainVisDiv .visBtn a.rollBt").eq(mainVisNum).find(".bar"), 0, {width:0, ease:Power0.easeOut});
					TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum), 1, {left:"-100%", ease:Power2.easeOut});
					mainVisNum = i;
					rollNum = i;
					if(mainVisNum == 0) videoEvent();
					$(".mainVisDiv .visBtn a.rollBt").eq(mainVisNum).addClass("on");
					TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum), 0, {left:"100%", ease:Power2.easeOut});
					TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt1").find("img"), 0, {top:152, ease:Power4.easeOut});
					TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt2").find("img"), 0, {top:240, ease:Power4.easeOut});
					TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt3"), 0, {top:315, opacity:0, ease:Power4.easeOut});
					TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum), 1, {left:"0", ease:Power2.easeOut, onComplete:function(){
						TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt1").find("img"), 0.6, {top:0, delay:0.1, ease:Power4.easeOut, onComplete:function(){
							isRollMove = false;
						}});
						TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt2").find("img"), 0.6, {top:0, delay:0.4, ease:Power4.easeOut});
						TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt3"), 1.7, {top:265, opacity:1, delay:0.8, ease:Power4.easeOut});
						TweenMax.to($(".mainVisDiv .visBtn a").eq(mainVisNum).find(".bar"), 2, {width:"100%", ease:Power0.easeOut});
					}});
				}
			}
			clearInterval(vInterval);
			vInterval = setInterval("rollingEvent()", vTime);
		});
	})
}

function mainCon1(){
	if($(window).width() > 976){
		TweenMax.to($(".mainCon1 .listDiv .list3"), 0.6, {top:0, opacity:1, delay:2, ease:Power3.easeOut});
		TweenMax.to($(".mainCon1 .listDiv .list4"), 0.6, {top:0, opacity:1, delay:2.2, ease:Power3.easeOut});
	}else{
		TweenMax.to($(".mainCon1 .listDiv .list3"), 0.6, {top:280, opacity:1, delay:2, ease:Power3.easeOut});
		TweenMax.to($(".mainCon1 .listDiv .list4"), 0.6, {top:280, opacity:1, delay:2.2, ease:Power3.easeOut});
	}
	TweenMax.to($(".mainCon1 .txt1"), 1, {top:181, opacity:1, delay:.8, ease:Power3.easeOut});
	TweenMax.to($(".mainCon1 .txt2"), 1, {top:243, opacity:1, delay:1.1, ease:Power3.easeOut});
		TweenMax.to($(".mainCon1 .txt3"), 1, {top:283, opacity:1, delay:1.1, ease:Power3.easeOut});
	TweenMax.to($(".mainCon1 .listDiv .list1"), 0.6, {top:0, opacity:1, delay:1.6, ease:Power3.easeOut});
	TweenMax.to($(".mainCon1 .listDiv .list2"), 0.6, {top:0, opacity:1, delay:1.8, ease:Power3.easeOut});
	
};
function mainCon1_start(){
	TweenMax.to($(".mainCon1 .txt1"), 0, {top:281, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon1 .txt2"), 0, {top:363, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon1 .listDiv .list"), 0, {top:50, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon1 .listDiv .list3"), 0, {top:330, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon1 .listDiv .list4"), 0, {top:330, opacity:0, ease:Power3.easeOut});
};


function mainCon2(){
	TweenMax.to($(".mainCon2 .txt1"), 1, {top:151, opacity:1, delay:.8, ease:Power3.easeOut});
	TweenMax.to($(".mainCon2 .txt2"), 1, {top:213, opacity:1, delay:1.1, ease:Power3.easeOut});
	TweenMax.to($(".mainCon2 .swiper-container"), 1, {top:270, opacity:1, delay:1.3, ease:Power3.easeOut});
};
function mainCon2_start(){
	TweenMax.to($(".mainCon2 .txt1"), 0, {top:281, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon2 .txt2"), 0, {top:363, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon2 .swiper-container"), 0, {top:350, opacity:0, ease:Power3.easeOut});
};


function mainCon3(){
	TweenMax.to($(".mainCon3 .txt1"), 1, {top:181, opacity:1, delay:.8, ease:Power3.easeOut});
	TweenMax.to($(".mainCon3 .txt2"), 1, {top:263, opacity:1, delay:1.1, ease:Power3.easeOut});
	TweenMax.to($(".mainCon3 .careerDiv"), 1, {top:320, opacity:1, delay:1.3, ease:Power3.easeOut})
};
function mainCon3_start(){
	TweenMax.to($(".mainCon3 .txt1"), 0, {top:281, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon3 .txt2"), 0, {top:363, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon3 .careerDiv"), 0, {top:420, opacity:0, ease:Power3.easeOut})
};

function mainCon4(){
	TweenMax.to($(".mainCon4 .txt1"), 1, {top:131, opacity:1, delay:.8, ease:Power3.easeOut});
	TweenMax.to($(".mainCon4 .txt2"), 1, {top:213, opacity:1, delay:1.1, ease:Power3.easeOut});
	TweenMax.to($(".mainCon4 .swiper-container"), 1, {top:270, opacity:1, delay:1.3, ease:Power3.easeOut});
};
function mainCon4_start(){
	TweenMax.to($(".mainCon4 .txt1"), 0, {top:281, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon4 .txt2"), 0, {top:363, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon4 .swiper-container"), 0, {top:350, opacity:0, ease:Power3.easeOut});
};

function mainCon5(){
	TweenMax.to($(".mainCon5 .txt1"), 1, {top:181, opacity:1, delay:.8, ease:Power3.easeOut});
	TweenMax.to($(".mainCon5 .txt2"), 1, {top:263, opacity:1, delay:1.1, ease:Power3.easeOut});
	TweenMax.to($(".mainCon5 .careerDiv"), 1, {top:320, opacity:1, delay:1.3, ease:Power3.easeOut})
};
function mainCon5_start(){
	TweenMax.to($(".mainCon5 .txt1"), 0, {top:281, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon5 .txt2"), 0, {top:363, opacity:0, ease:Power3.easeOut});
	TweenMax.to($(".mainCon5 .careerDiv"), 0, {top:420, opacity:0, ease:Power3.easeOut})
};



function rollingEvent(){
	$(".mainVisDiv .visBtn a").eq(mainVisNum).removeClass("on");
	TweenMax.to($(".mainVisDiv .visBtn a").eq(mainVisNum).find(".bar"), 0, {width:0, ease:Power0.easeOut});
	TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum), 1, {left:"-100%", ease:Power2.easeOut});
	mainVisNum++;
	if(mainVisNum > mainVisMax){
		mainVisNum = 0;
	};
	if(mainVisNum == 0) videoEvent();
	$(".mainVisDiv .visBtn a").eq(mainVisNum).addClass("on");
	TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum), 0, {left:"100%", ease:Power2.easeOut});
	TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt1").find("img"), 0, {top:152, ease:Power4.easeOut});
	TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt2").find("img"), 0, {top:240, ease:Power4.easeOut});
	TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt3"), 0, {top:315, opacity:0, ease:Power4.easeOut});
	TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum), 1, {left:"0", ease:Power2.easeOut, onComplete:function(){
		TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt1").find("img"), 0.6, {top:0, delay:0.5, ease:Power4.easeOut});
		TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt2").find("img"), 0.6, {top:0, delay:0.9, ease:Power4.easeOut});
		TweenMax.to($(".mainVisDiv .visArea .visual").eq(mainVisNum).find(".txt3"), 1.7, {top:265, opacity:1, delay:1.3, ease:Power4.easeOut});
		TweenMax.to($(".mainVisDiv .visBtn a").eq(mainVisNum).find(".bar"), 2, {width:"100%", ease:Power0.easeOut});
	}});
}

function videoEvent(){
	if($(".mainVisDiv .visArea .visual video").size() > 0){
		mainVideo = document.getElementById("myvideo");
		mainVideo.loop = false;
		mainVideo.pause();
		mainVideo.load();
		mainVideo.play();
		mainVideo.onplay = function(){
			videoPlay = true;
			clearInterval(vInterval);
		};
		mainVideo.onended = function(){
			mainVideo.pause();
			videoPlay = false;
			$(".mainVisDiv .visBtn a").eq(1).click();
			vInterval = setInterval("rollingEvent()", vTime);
		};
	}else{
		videoPlay = false;
		clearInterval(vInterval);
		vInterval = setInterval("rollingEvent()", vTime);
	}
}

var _windowH;
var _mainWrapH, _mainWrapH_scroll;
var _isViewVisualTab = false;

function visualH(){
	_windowH = $(window).height();
	_mainWrapH = $(document).height();
	_mainWrapH_scroll = _mainWrapH;
}

function scrollStarEndChk(){
	if($(window).width() > 1230){
		if ($(window).scrollTop() == $(document).height() - $(window).height()) {
			_isScrollEnd = true;
			_isScrollStart = false;
		} else if ($(window).scrollTop() == 0) {	
			_isScrollEnd = false;
			_isScrollStart = true;
		} else {
			_isScrollEnd = _isScrollStart = false;
		}

		if($(window).width() > 1230){
			if($(window).height() < 768) {									//스크롤 생길때 #wBody 높이값 제한
				_isHasScroll = true;
					$("#wBody").css("height", "785");
					_mainWrapH = 785;
			} else {
				_isHasScroll = false;
				_mainWrapH = $(document).height();
			}
		}
	}
}