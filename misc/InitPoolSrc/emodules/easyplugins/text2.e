
/*******************************************
    text2_plugin.e (part OF EasyPLUGINs)

    text plugin by Ali Graham
    modified by -=JG=-

    now allow text to be set, however
    initial text needs to be largest
    required as min size calculated from
    the initial text.  Just fill with M's
    to size required and .set to required
    initial value after guiinit."
 *******************************************/

OPT MODULE, PREPROCESS, OSVERSION=37

->> text_plugin: Modules

MODULE 'tools/easygui', 'graphics/text', 'tools/ghost',
       'intuition/intuition', 'intuition/screens',
       'graphics/rastport'

MODULE 'utility', 'utility/tagitem'

-><

/* $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ */

->> text_plugin: Definitions
EXPORT OBJECT text_plugin OF plugin PRIVATE

    contents:PTR TO CHAR
    highlight
    three_d
    justification
    draw_bar
    font:PTR TO textattr
    disabled

    text_width
    text_height

ENDOBJECT

-> PROGRAMMER_ID | MODULE_ID
->      $01      |   $02

EXPORT ENUM PLA_Text_Text=$81020001,        ->[ISG]
            PLA_Text_Highlight,             ->[ISG]
            PLA_Text_ThreeD,                ->[ISG]
            PLA_Text_Justification,         ->[ISG]
            PLA_Text_DrawBar,               ->[ISG]
            PLA_Text_Font,                  ->[I.G]
            PLA_Text_Disabled               ->[ISG]

EXPORT ENUM PLV_Text_JustifyCenter=0,
            PLV_Text_JustifyLeft,
            PLV_Text_JustifyRight

-><

/* $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ */

->> text_plugin: text()
PROC text(tags=NIL:PTR TO tagitem) OF text_plugin

    IF utilitybase

        self.contents       := GetTagData(PLA_Text_Text, '', tags)
        self.highlight      := GetTagData(PLA_Text_Highlight, FALSE, tags)
        self.three_d        := GetTagData(PLA_Text_ThreeD, FALSE, tags)
        self.font           := GetTagData(PLA_Text_Font, NIL, tags)
        self.justification  := GetTagData(PLA_Text_Justification, PLV_Text_JustifyCenter, tags)
        self.draw_bar       := GetTagData(PLA_Text_DrawBar, FALSE, tags)
        self.disabled       := GetTagData(PLA_Text_Disabled, FALSE, tags)

    ELSE

        Raise("util")

    ENDIF

ENDPROC
-><

->> text_plugin: set() & get()

PROC set(attr, value) OF text_plugin

    SELECT attr
        CASE PLA_Text_Text

          self.contents:=value
          IF (self.disabled=FALSE)
            self.min_size(self.font, self.font.ysize)
            self.draw(self.gh.wnd)
          ENDIF

        CASE PLA_Text_Highlight

            IF self.highlight<>value

                self.highlight:=value
                IF (self.disabled=FALSE) THEN  self.draw(self.gh.wnd)

            ENDIF

        CASE PLA_Text_ThreeD

            IF self.three_d<>value

                self.three_d:=value

                IF (self.disabled=FALSE) THEN  self.draw(self.gh.wnd)

            ENDIF

        CASE PLA_Text_Justification

            IF self.justification<>value

                IF (value >= PLV_Text_JustifyCenter) AND (value <= PLV_Text_JustifyRight)

                    self.justification:=value

                    IF (self.disabled=FALSE) THEN  self.draw(self.gh.wnd)

                ENDIF

            ENDIF

        CASE PLA_Text_DrawBar

            IF self.draw_bar<>value

                self.draw_bar:=value

                IF (self.disabled=FALSE) THEN  self.draw(self.gh.wnd)

            ENDIF

        CASE PLA_Text_Disabled

            IF self.disabled<>value

                self.disabled:=value

                self.draw(self.gh.wnd)

            ENDIF

    ENDSELECT

ENDPROC

PROC get(attr) OF text_plugin

    SELECT attr

        CASE PLA_Text_Text;             RETURN self.contents, TRUE
        CASE PLA_Text_Highlight;        RETURN self.highlight, TRUE
        CASE PLA_Text_ThreeD;           RETURN self.three_d, TRUE
        CASE PLA_Text_Justification;    RETURN self.justification, TRUE
        CASE PLA_Text_DrawBar;          RETURN self.draw_bar, TRUE
        CASE PLA_Text_Font;             RETURN self.font, TRUE
        CASE PLA_Text_Disabled;         RETURN self.disabled, TRUE

    ENDSELECT

ENDPROC -1, FALSE

-><

->> text_plugin: draw()
PROC draw(win:PTR TO window, font=NIL:PTR TO textattr) OF text_plugin

    DEF left_side, right_side, text_start, gap, line_height, justification

    IF win
        SetStdRast(win.rport)

        Box(self.x, self.y, (self.x+(self.xs-1)), (self.y+(self.ys-1)), 0)

        IF self.disabled=FALSE

            line_height:=self.y + (self.text_height/2)

            left_side:=self.x + 2
            right_side:=self.x + self.xs -3

            gap:=6

            IF self.font;       font:=self.font
            ELSEIF font=NIL;    font:=win.wscreen.font
            ENDIF

            justification:=self.justification

            SELECT justification

                CASE PLV_Text_JustifyLeft

                    print_text(self, font, left_side, self.y)
                    IF self.draw_bar THEN draw_line((left_side + self.text_width + gap), right_side, line_height)

                CASE PLV_Text_JustifyRight

                    IF self.draw_bar THEN draw_line(left_side, (right_side - (self.text_width + gap)), line_height)
                    print_text(self, font, (right_side - self.text_width), self.y)

                DEFAULT

                    text_start:=left_side + (((right_side - left_side) - self.text_width) / 2) + 1

                    IF self.draw_bar THEN draw_line(left_side, (text_start - gap), line_height)
                    print_text(self, font, text_start, self.y)
                    IF self.draw_bar THEN draw_line((text_start + self.text_width + gap), right_side, line_height)

            ENDSELECT

        ELSE

            ghost(win, self.x, self.y, self.xs, self.ys)

        ENDIF

    ENDIF

ENDPROC
-><

->> text_plugin: min_size() & will_resize()
PROC min_size(font:PTR TO textattr, font_height) OF text_plugin

    self.text_width:= IntuiTextLength([1, 0, RP_JAM1, 0, 0,
                                      (IF self.font THEN self.font ELSE font),
                                      self.contents, NIL]:intuitext)

    self.text_height:=(IF self.font THEN self.font.ysize ELSE font_height)

ENDPROC (self.text_width + 24), (self.text_height + 2)

PROC will_resize() OF text_plugin IS COND_RESIZEX

-><

->> text_plugin: render()

PROC render(font:PTR TO textattr, x, y, xs, ys, win:PTR TO window) OF text_plugin

    self.draw(win, font)

ENDPROC

-><

->> private to text_plugin.draw(): draw_line() & print_text()
PROC draw_line(x1, x2, y)

    Line(x1, y, x2, y, 1)
    Line(x1, y+1, x2, y+1, 2)

ENDPROC

PROC print_text(t:PTR TO text_plugin, font:PTR TO textattr, x, y)

    DEF bt_col, ft_col

    IF t.highlight

        bt_col:=1; ft_col:=2

    ELSE

        bt_col:=2; ft_col:=1

    ENDIF

    IF t.three_d THEN PrintIText(stdrast, [bt_col, 0, RP_JAM1, 1, 1, font, t.contents, NIL]:intuitext, x, y)

    PrintIText(stdrast, [ft_col, 0, RP_JAM1, 0, 0, font, t.contents, NIL]:intuitext, x, y)

ENDPROC
-><



