/*
PartialViewSLider: https://github.com/VeeK727/partialViewSlider
Version: 0.2
Author: Vipul Kapoor (@MrVipulKapoor)
Licenced under: MIT License

Copyright (c) 2018 Vipul Kapoor

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

;(function ($, window, doucment, undefined) {
	var pluginName = 'partialViewSlider',
    defaults = {
      width: 70,
      controls: true,
      controlsPosition: 'inside', //inside, outside, neighbors
      backdrop: true,
      dots: false,
    	auto: true,
      transitionSpeed: 400,
      delay: 4000,
      pauseOnHover: true,
      keyboard: true,
      perspective: false,
      prevHtml: '<span class="glyphicon glyphicon-chevron-left"></span>',
      nextHtml: '<span class="glyphicon glyphicon-chevron-right"></span>',
      onLoad: function() {},
      onSlideEnd : function() {}
    };

  function Plugin( element, options ) {
    this.element = element;
    this.options = $.extend( {}, defaults, options) ;

    this._defaults = defaults;
    this._name = pluginName;

    this.init();
  }

  function calculateNumbers(self){
  	var el = $(self.element);

    self.slides = el.find('li');
  	self.numElements = self.slides.length,
  	self.numSlides = self.numElements-4,
  	self.wrapperWidth = $(self.wrapper).width(),
  	self.slideWidth = self.wrapperWidth*(self.options.width)/100,
  	self.sideWidth = self.wrapperWidth*((100 - self.options.width)/2)/100;

    self.slideMovement = self.wrapperWidth*self.options.width/100;
    self.firstMovement = self.currentPosition = -(self.slideWidth-self.sideWidth+self.slideWidth);
  }

  function moveSlider(self, direction){
  	var el = $(self.element);

  	if(direction == 'forward'){
    	self.index++;
    	self.currentPosition -= self.slideWidth;
  	} else if(direction == 'backward'){
    	self.index--;
    	self.currentPosition += self.slideWidth;
  	} else {
  		var index = parseInt(direction);
  		if(index <= self.numSlides && index > 0){
 	 			self.index = index-1;
 	 			self.currentPosition = self.firstMovement - (self.index * self.slideWidth);
  		}
  	}
  	$(self.slides[self.index+2]).addClass('active').siblings().removeClass('active');
  	if(self.options.dots)
	  	$(self.dots[self.index]).addClass('active').siblings().removeClass('active');
  	el.css({
  		'-webkit-transform': 'translateX('+self.currentPosition+'px)',
  		'transform': 'translateX('+self.currentPosition+'px)'
  	});

  	setTimeout(function() {
    	if(self.index > self.numSlides-1){
    		self.index = 0;
    		self.currentPosition = self.firstMovement;
    		var loop = true;
    	} else if(self.index < 0){
    		self.index = self.numSlides-1;
    		self.currentPosition -= self.numSlides*self.slideWidth;
    		var loop = true
    	} else {
    		var loop = false;
    	}
    	if(loop){
    		$(self.slides).css('transition-duration', '0ms');
    		$(self.slides[self.index+2]).addClass('active').siblings().removeClass('active');
    		if(self.options.dots)
    			$(self.dots[self.index]).addClass('active').siblings().removeClass('active');
    		el.css({
    			'transition-duration': '0ms',
    			'-webkit-transform': 'translateX('+self.currentPosition+'px)',
    			'transform': 'translateX('+self.currentPosition+'px)'
    		});
    		setTimeout(function() {
    			el.css('transition-duration', self.options.transitionSpeed+'ms');
    			$(self.slides).css('transition-duration', self.options.transitionSpeed+'ms');

    		}, 20);
    	}

  		self.options.onSlideEnd.call(self.element);
  	}, self.options.transitionSpeed);
  }

	var xDown = null;
	var yDown = null;

	function getTouches(evt) {
	  return evt.touches ||             // browser API
	         evt.originalEvent.touches; // jQuery
	}

	function handleTouchStart(evt) {
    xDown = getTouches(evt)[0].clientX;
    yDown = getTouches(evt)[0].clientY;
	};

	function handleTouchMove(evt, self) {
    if(!xDown || !yDown){
      return;
    }

    var xUp = getTouches(evt)[0].clientX;
    var yUp = getTouches(evt)[0].clientY;
    var xDiff = xDown - xUp;
    var yDiff = yDown - yUp;

    if ( Math.abs( xDiff ) > Math.abs( yDiff ) ) {
      if ( xDiff < 0 ) {
        moveSlider(self, 'backward');
      } else {
        moveSlider(self, 'forward');
      }
    }
    /* reset values */
    xDown = null;
    yDown = null;
	};

	function firstMovement(self){
		var el = $(self.element);
		self.index = 0;
    el.width(self.numElements*self.slideWidth);
  	$(self.slides).width(self.slideWidth);
    el.css({
    	'-webkit-transform': 'translateX('+(self.firstMovement)+'px)',
    	'transform': 'translateX('+(self.firstMovement)+'px)'
    });
    $(self.slides[2]).addClass('active').siblings().removeClass('active');
    if(self.options.dots)
    	$(self.dots[0]).addClass('active').siblings().removeClass('active');

    el.siblings('.partialViewSlider-backdrop').css('width', self.sideWidth);

    setTimeout(function() {
    	el.css('transition-duration', self.options.transitionSpeed+'ms');
    	$(self.slides).css('transition-duration', self.options.transitionSpeed+'ms');
    }, 20);
	};

  $.extend( Plugin.prototype, {
		init: function() {
			var self, el;
			self = this;

    	el = $(this.element);
	    el.wrap('<div class="partialViewSlider-outerwrapper"><div class="partialViewSlider-wrapper"></div></div>');

	    this.outerWrapper = el.closest('.partialViewSlider-outerwrapper'),
	    this.wrapper = el.closest('.partialViewSlider-wrapper');

	    if(this.options.controlsPosition == 'outside'){
	    	$(this.outerWrapper).addClass('partialViewSlider-outsideControls');
	    } else if(this.options.controlsPosition == 'neighbors'){
	    	$(this.outerWrapper).addClass('partialViewSlider-neighborControls');
	    }

	    var first_slide = el.find("li").slice(0,2),
		  	last_slide = el.find("li").slice(-2);
		  el.prepend(last_slide.clone().addClass('partialViewSlider-clone'));
		  el.append(first_slide.clone().addClass('partialViewSlider-clone'));

		  calculateNumbers(this);

	    if(this.options.perspective){
	    	$(this.wrapper).addClass('partialViewSlider-perspective');
	    }

	    if(this.options.controls){
		    $(this.outerWrapper).append('<a href="#" class="partialViewSlider-nav partialViewSlider-prev">'+this.options.prevHtml+'</a>');
		    $(this.outerWrapper).append('<a href="#" class="partialViewSlider-nav partialViewSlider-next">'+this.options.nextHtml+'</a>');

		    $(this.outerWrapper).on('click', '.partialViewSlider-next', function(e){
		    	e.preventDefault();
		    	moveSlider(self, 'forward');
		    });

		    $(this.outerWrapper).on('click', '.partialViewSlider-prev', function(e){
		    	e.preventDefault();
		    	moveSlider(self, 'backward');
		    });
		  }

	    if(this.options.backdrop){
		    $(this.wrapper).append('<div class="partialViewSlider-backdrop"></div>');
		    $(this.wrapper).append('<div class="partialViewSlider-backdrop partialViewSlider-right"></div>');
		  }

		  if(this.options.dots){
		  	var dotsHtml = '<ul class="partialViewSlider-dots">';
		  	for (var i = 0; i < this.numSlides; i++) {
		  		dotsHtml += '<li><a href="#"></a></li>';
		  	}
		  	dotsHtml += '</ul>';
		  	$(this.outerWrapper).append(dotsHtml);
		  	self.dots = this.dots = $(this.outerWrapper).find('.partialViewSlider-dots li');

		  	$(this.outerWrapper).on('click', '.partialViewSlider-dots li', function(e){
		    	e.preventDefault();
		    	var index = $(self.dots).index(this);
		    	moveSlider(self, index+1);
		    });
		  }

	    firstMovement(this);

	    if(this.options.auto){
	    	self.looper = this.looper = setInterval(function(){
	    		moveSlider(self, 'forward');
	    	}, this.options.delay);

	    	if(this.options.pauseOnHover){
	    		$(this.wrapper).on('mouseenter', function(){
	    			clearInterval(self.looper);
	    		});
	    		$(this.wrapper).on('mouseleave', function(){
	    			self.looper = this.looper = setInterval(function(){
			    		moveSlider(self, 'forward');
			    	}, self.options.delay);
	    		});
	    	}
	    }

	    if(this.options.keyboard){
	    	$(document).on('keyup', function(e){
          if(!$(':focus').is('input, textarea')) {
            if (e.keyCode === 37) {
              moveSlider(self, 'backward');
            } else if (e.keyCode === 39) {
              moveSlider(self, 'forward');
            }
          }
        });
	    }

	    var resize;
	    $(window).on('resize orientationchange', function(){
	    	clearTimeout(resize);
	    	resize = setTimeout(function() {
	    		calculateNumbers(self);
	    		firstMovement(self)
	    	}, 500);
	    });

	    document.addEventListener('touchstart', handleTouchStart, false);
			document.addEventListener('touchmove', function(event){
				handleTouchMove(event, self);
			}, false);

	    this.options.onLoad.call(el);
	  },
	  prev: function(){
	  	moveSlider(this, 'backward');
	  },
	  next: function(){
	  	moveSlider(this, 'forward');
	  },
	  play: function(){
	  	var self = this;
	  	clearInterval(this.looper);
	  	this.looper = setInterval(function(){
    		moveSlider(self, 'forward');
    	}, self.options.delay);
	  },
	  pause: function(){
	  	clearInterval(this.looper);
	  },
	  goToSlide: function(index){
	  	moveSlider(this, index);
	  }
  });

  $.fn[pluginName] = function ( options ) {
  	var plugin;
    this.each(function () {
      plugin = $.data(this, 'plugin_' + pluginName);
	    if (!plugin) {
	      plugin = new Plugin(this, options);
	      $.data(this, 'plugin_' + pluginName, plugin);
	    }
    });

    return plugin;
  }
}(jQuery, window, document));