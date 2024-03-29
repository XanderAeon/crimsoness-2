function st_textnvl() {
	//surface_set_target(global.surfaces.HUD);
	for (i=array_length(bg)-1; i>=0; i--) {
		var realspeed = sprite_get_speed(bg[i])/60;
		
		draw_sprite(bg[i], bgspeed*realspeed, 0, 0);
	}
	bglogic();
	for (i=array_length(talker)-1; i>=0; i--) {
		draw_sprite_ext(talker[i].sprite,
		talker[i].index,
		talker[i].x,
		talker[i].y,
		ineg(talker[i].position > SPRITEPOS.CENTER),
		1, 0, make_color_hsv(0, 0, 255-(i>0)*100), talker[i].alpha*(talker[i].position <= SPRITEPOS.RIGHT));
	}
	for (i=array_length(fg)-1; i>=0; i--) {
		var realspeed = sprite_get_speed(fg[i])/60;
		
		draw_sprite(fg[i], bgspeed*realspeed, 0, 0);
	}
	fglogic();
	if halting {exit}
	surface_set_target(global.textsurf);
	draw_sprite(sprite_index, 0, x, y);
	draw_set_font(font);
	clr = c_white;
	var xpos = 0;
	var lb = 0;
	sizemult = 1;
	var effchars = drawchars;
	specialchars = 0;
	wigglex = 0;
	wiggley = 0;
	shake = 0;
	sizepos = 0;
	pressing = 0;
	fontsize = font_get_size(draw_get_font())*.8;
	backlogging = true;
	atsound = 0;
	atfunc = 0;
	j = 0;
	for (j=0; j<array_length(backlog); j++) {
		if backlog[j].type == "normal" {
			draw_set_color(backlog[j].guy.namecolor);
			draw_set_halign(fa_right);
			draw_text(x-width/2-40, y+(fontsize)+(lb+nvlline)*(fontsize*2), backlog[j].guy.displayname);
			draw_set_halign(fa_left);
			draw_set_color(c_white);
		}
		draw_set_halign(fa_left);
		for (i=1; i<=string_length(backlog[j].text)+1; i++) {
			while string_char_at(backlog[j].text, i) = "|" {
		        c_txtspecial();
		    }
			effchars = drawchars+specialchars;
			var centerOffset = 0;
			if(draw_get_halign() == fa_center || draw_get_halign() == fa_right) {
				var linelist = string_split(backlog[j].text,"#");
				var msglen = string_length(linelist[lb])
				centeroffset = ((width/(fontsize+5))) - msglen;
				if(draw_get_halign() == fa_center) {
					centeroffset/=2;
				}
			}
			var textoffsetx = cos((count+i*2)/(talkspeed*20))*wigglex+random(shake/2)-shake/4;
			var textoffsety = sin((count+i*2)/(talkspeed*20))*wiggley+random(shake/2)-shake/4;
			var textxpos = x+margin+(xpos+centerOffset)*(fontsize)-width/2;
			var textypos = y+(fontsize)+(lb+nvlline)*(fontsize*2);
			var thechar = string_hash_to_newline(string_char_at(backlog[j].text, i));
		    draw_text_ext_transformed_colour(textxpos+textoffsetx, textypos+textoffsety, thechar, 0, 999, sizemult, sizemult, 0, clr, clr, clr, clr, 1);
		    if string_char_at(backlog[j].text, i) = "#" {
		        lb++;
		        xpos = -1;
		    }
		    xpos += sizemult;
		}
		draw_set_font(font);
		lb++;
		clr = c_white;
		var clrdur = 0;
		var xpos = 0;
		sizemult = 1;
		var effchars = drawchars;
		specialchars = 0;
		wigglex = 0;
		wiggley = 0;
		shake = 0;
		sizepos = 0;
		pressing = 0;
		fontsize = font_get_size(draw_get_font())*.8;
		atsound = 0;
		atfunc = 0;
	}
	backlogging = false;
	if msg[talkpos].type == "normal" {
			draw_set_color(msg[talkpos].guy.namecolor);
			draw_set_halign(fa_right);
			draw_text(x-width/2-40, y+(fontsize)+(lb+nvlline)*(fontsize*2), talker[0].displayname);
			draw_set_halign(fa_left);
			draw_set_color(c_white);
		}
	atsound = 0;
	atfunc = 0;
	for (i=1; i<=effchars; i++) {
		while string_char_at(msg[talkpos].text, i) = "|" {
	        c_txtspecial();
	    }
		effchars = drawchars+specialchars;
		var centerOffset = 0;
		if(draw_get_halign() == fa_center || draw_get_halign() == fa_right) {
			var linelist = string_split(msg[talkpos].text,"#");
			var msglen = string_length(linelist[lb]);
			centeroffset = ((width/(fontsize+5))) - msglen;
			if(draw_get_halign() == fa_center) {
				centeroffset/=2;
			}
		}
		var textoffsetx = cos((count+i*2)/(talkspeed*20))*wigglex+random(shake/2)-shake/4;
		var textoffsety = sin((count+i*2)/(talkspeed*20))*wiggley+random(shake/2)-shake/4;
		var textxpos = x+margin+(xpos+centerOffset)*(fontsize)-width/2;
		var textypos = y+(fontsize)+(lb+nvlline)*(fontsize*2);
		var thechar = string_hash_to_newline(string_char_at(msg[talkpos].text, i));
	    draw_text_ext_transformed_colour(textxpos+textoffsetx, textypos+textoffsety, thechar, 0, 999, sizemult, sizemult, 0, clr, clr, clr, clr, 1);
	    if string_char_at(msg[talkpos].text, i) = "#" {
	        lb++;
	        xpos = -1;
	    }
	    xpos += sizemult;
	}
	for (i=array_length(sg)-1; i>=0; i--) {
		var realspeed = sprite_get_speed(sg[i])/60;
		
		draw_sprite(sg[i], bgspeed*realspeed, 0, 0);
	}
	sglogic();
	surface_reset_target();
}