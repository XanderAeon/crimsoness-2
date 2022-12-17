function textbox_create(textscript=txt_test, style=global.textstyles.blue, advancable=true, destroyothers=true) {
	instance_destroy(destroyothers ? o_textbox : noone);
	var chump = instance_create(style.x, style.y, o_textbox);
	chump.width = style.width;
	chump.height = style.height;
	chump.spriteposy = style.spriteposy;
	chump.naturaladvance = advancable;
	chump.advance = advancable;
	chump.msgscript = textscript;
	chump.sprite_index = style.sprite;
	chump.namepos = style.namepos;
	chump.font = style.font;
	chump.draw = method(chump, style.type);
	chump.style = style;
	with chump {
		msgscript();
		textline_next();
	}
	return chump;
}