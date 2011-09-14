(function($) {
	$.fn.extend({
		noisy : function(params) {
			return $.extend({
				noiseMaker : $.extend({
					opacity : .05,
					width : 20,
					bringNoise : function() {
						var x, y, mono,
								canvas = $("<canvas>", {width:this.width, height:this.width })[0],
								ctx = canvas.getContext("2d");
						for (x=0; x<canvas.width; x += 1) {
							for (y=0; y<canvas.height; y += 1) {
								mono = Math.floor(Math.random() *255);
								ctx.fillStyle = "rgba(" + [mono, mono, mono, this.opacity].join(",") + ")";
								ctx.fillRect(x, y, 1, 1);
							}
						}
						return canvas.toDataURL("image/png");
					},
					go : function(caller) {
						this.caller = caller;
						var noise = this.bringNoise();
						return caller.css("background-image", function(i, val) {
							return "url("+noise+")" + ", " + val;
						});
					}
				}, params)
			}).noiseMaker.go(this);
		}
	});
})(jQuery);
