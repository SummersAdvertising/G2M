function MSform( mailto, mailsub ){
	//define the rules of validation
	var valid = {
		check: function(){
			var isAccept = valid.isAccept();
			var notBlank = valid.notBlank();
			var isMail = valid.isMail();
			var isNumber = valid.isNumber();
			var isTel = valid.isTel();

			return isAccept && notBlank && isMail && isNumber && isTel; 
		},

		notBlank: function(element){
			var isPass = true;
			if(element){
				isPass = (element.val().length > 0)
				valid.showmsg(isPass, element)
				return isPass;
			}
			
			$("input.valid").each(function(){
				if(!$(this).val()){
					isPass = false;
					valid.showmsg(isPass, $(this));
				}
			});

			$("div.boxgroup").each(function(){
				if($(this).children("input:checked").length < 1){
					isPass = false;
					valid.showmsg(isPass, $(this));
				}
				else{
					valid.showmsg(true, $(this));
				}
			});

			return isPass;
		},
		isAccept: function(){
			if($("#acceptPrivacy:checked").length == 0){
				alert("您必須同意隱私權聲明以繼續操作");
				return false;
			}
			return true;
		},
		isMail: function(element){
			var isPass = true;
			var rege = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9])+$/;

			if(element){
				isPass = (element.val() && rege.exec(element.val()) );
				valid.showmsg(isPass, element);
				return isPass;
			}

			$("input[data-valid='mail']").each(function(){
				if(!$(this).val() || !rege.exec($(this).val()) ){
					isPass = false;
					valid.showmsg(isPass, $(this));
				}
			});

			return isPass;
		},
		isNumber: function(element){
			var isPass = true;
			var rege = /^[0-9]+$/;

			if(element){
				isPass = (element.val() && rege.exec( element.val()) );
				valid.showmsg(isPass, element);
				return isPass;
			}

			$("input[data-valid='number']").each(function(){
				if(!$(this).val() || !rege.exec($(this).val()) ){
					isPass = false;
					valid.showmsg(isPass, $(this));
				}
			})
			return isPass;
		},
		isTel: function(element){
			var isPass = true;
			var rege = /^[-()0-9 ]+$/;

			if(element){
				isPass = (element.val() && rege.exec(element.val()) );
				valid.showmsg(isPass, element);
				return isPass;
			}

			$("input[data-valid='tel']").each(function(){
				if(!$(this).val() || !rege.exec($(this).val()) ){
					isPass = false;
					valid.showmsg(isPass, $(this));
				}
			})
			return isPass;
		},

		getMailBody: function(){
			var mailBody = new String();
			$(".MSform").each(function(){
				var textbox = $(this);
				var value = new String();
				if(!textbox.is("input[type=text], textarea")){
					$(this).children("input:checked").each(function(){
						value += $(this).val()+", ";
					});
				}
				else{
					value = textbox.val();
				}
				mailBody += $(this).data("mailnote") + " " + value + "\n";
			});

			mailBody += "\n[我已同意隱私權聲明]";

			return mailBody;
		},

		showmsg:function(pass, element){
			if(element.is(".boxgroup")){
				var valid_pass = element.parents("table:first").find("p.right");
				var valid_fail = valid_pass.siblings("p.wrong");
			}
			else{
				var valid_pass = element.parent().siblings("td.verify").children("p.right");
				var valid_fail = valid_pass.siblings("p.wrong");
			}
			

			if(pass){
				valid_pass.show();
				valid_fail.hide();
			}
			else{
				valid_pass.hide();
				valid_fail.show();
			}
		}
	};

	//check when elements blur
	$("input.valid").blur(function(){
		switch($(this).data("valid")){

			case "mail":
				valid.isMail($(this));
			break;
			case "tel":
				valid.isTel($(this));
			break;
			case "number":
				valid.isNumber($(this));
			break;

			default:
				valid.notBlank($(this));
			break;

		}
	});

	//when privacy accepted, enable submit btn
	$("#acceptPrivacy").click(function(){
		if( $(this).is(":checked") ){
			$("#contactSend").removeAttr("disabled").addClass("on");
		}
		else{
			$("#contactSend").attr("disabled", true).removeClass("on");
		}
	});

	//when form submits
	$("#contactSend").click(function(event) {
		
		if(!valid.check()){
			alert("請將表單填寫完整。");
			return false;
		}
		var mailBody = valid.getMailBody();
		$("#copy-content").val(mailBody);

		$("#tips").show(function(){
			$("#copy-button").zclip({
				path:"js/ZeroClipboard.swf",
				copy:function(){
					return $("#copy-content").val();
				}
			})
			.click(function(){
				$("#copy-button").addClass("copy-success").html("已複製完成");
			});
		});
		
		var url = mailto + "?subject=" + Url.encode(mailsub) + "&body=" + Url.encode(mailBody);
		var w = window.open("mailto:"+url);		

		
		window.open("mailto.htm");

		setTimeout( function() {
			if (w.document.location.href.search('microsoft') < 50) { w.close(); }
		}, 100 );

		event.preventDefault();
	});

	$(".checkbox :checkbox, .radio :radio").click(function() {
        if ($(this).is(":checked")) {
         $(this).parent("div.boxgroup:first").children("input").not(":checked").each(function() {
                 $(this).next().css("color", "#ccc");
                });

            $(this)
                .next()
                .css("color", "#2B6AD2");

            valid.showmsg(true, $(this).parent("div.boxgroup:first"));
        } else {
         if ($(this).siblings("input:checked").length < 1) {
          $(this).parent("div.boxgroup:first").children("input").each(function() {
                 $(this).next().css("color", "#aaa");
                });
          valid.showmsg(false, $(this).parent("div.boxgroup:first"));
            }
            else{
             $(this).next().css("color", "#ccc");
            }
        }
    });
}