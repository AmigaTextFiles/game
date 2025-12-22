CC     = vc +newlib
RM     = delete

# Change these as required
OPTIMIZE = -O4 -maxoptpasses=15
DEBUG =
CFLAGS = $(OPTIMIZE) $(DEBUG) -I. -Iinclude -D__USE_INLINE__

# Flags passed to gcc during linking
LINK = #$(OPTIMIZE) $(DEBUG)

# Name of the "thing" to build
TARGET  = MissCmd
VERSION = 0

# Additional linker libraries
LIBS = 

# Source code files used in this project
# Add any additional files to this line

SRCS = startup.c game.c cfg.c \
	timer.c entropy.c \
	gfx.c iconify.c pointer.c gfx_io.c gfx_blit.c gfx_primitives.c gfx_gradient.c gfx_text.c \
	gfx_clear.c gfx_ui.c gfx_ui_hiscore.c \
	audio_io.c audio_ahi.c \
	coll.c buildings.c missiles.c

# -------------------------------------------------------------
# Nothing should need changing below this line

OBJS = $(SRCS:.c=.o)

# Rules for building
$(TARGET): $(OBJS)
	$(CC) $(LINK) -o $(TARGET) $(OBJS) $(LIBS)

.PHONY: clean
clean:
	$(RM) $(TARGET) $(OBJS)

.PHONY: revision
revision:
	bumprev $(VERSION) $(TARGET)

