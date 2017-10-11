
-include ../../../config.mk
BUILD=$(BUILDDIR)
TARGET=$(BUILD)/tests
TOPSRC=$(TOP_SRC)
MOD_DIR=$(PWD)/../
TOP_INC_DIR=$(TOP_SRC)/modules

OBJS:=$(patsubst %.c,$(BUILD)/%.o,$(wildcard *.c))
OPTIMIZE_ZFS= $(NDEBUG) $(EVIL_DEBUG) -g $(OPTIMIZE_LEVEL) -fno-strict-aliasing -Wall
INCLUDE_DIRS:=\
	$(INCLUDE_DIRS) $(INCLUDE_DIRS_ZFS)\
	-I../include \
	-I$(TOP_INC_DIR) \
	-I$(MOD_DIR)/include \
	-I$(TOP_INC_DIR)/auxiliary \
	-I$(TOP_INC_DIR)/cjson  \
	-I$(TOP_INC_DIR)/uds_disk \
	-I$(TOP_INC_DIR)/gettext \
	-I$(TOP_INC_DIR)/utils

STD=$(USE_STD_C11)
LIBS=\
	 -pthread \
	 -L$(LIB_DIR) \
	 -L$(BUILDDIR) \
	 -l$(LIBRARY) \
	 -lzfs \
	 -lzpool \
	 -lnvpair -lev -lcheck -lm -lrt -lsubunit -luds_utils \
	 $(LIB_DIR)/json_rpc_server.a \
	 $(LIB_DIR)/json_rpc_client.a \
	 -lcjson 
TARGET_LIBS=$(BUILDDIR)/lib$(LIBRARY).a
VALGRIND_ARGS?=--leak-check=full --log-file=/tmp/valgrind.log --show-leak-kinds=all

all: $(TARGET)

$(BUILD)/%.o: %.c
	$(CC) $(STD) $(SYSTEM) -c $(OPTIMIZE_ZFS) $(PIC) $(CFLAGS) $(DEFS) $(INCLUDE_DIRS) -o $@ $<
	$(MKDEP) $(STD) $(SYSTEM) $(CPPFLAGS) $(INCLUDE_DIRS) $< | $(MKDEPFIX) > $@.d

$(TARGET): $(OBJS) $(TARGET_LIBS)
	$(CC) -o $@ $(OBJS) $(STATIC_LIBS) $(LIBS) $(GLIB_LIB)

run: $(TARGET)
	sudo CK_DEFAULT_TIMEOUT=100000000000000000 $(TARGET)

gdb: $(TARGET)
	sudo CK_DEFAULT_TIMEOUT=100000000000000000 CK_FORK=no gdb $(TARGET)

valgrind: $(TARGET)
	sudo CK_DEFAULT_TIMEOUT=100000000000000000 CK_FORK=no valgrind  $(VALGRIND_ARGS) $(TARGET)
	sudo chown $(USER):$(USER) /tmp/valgrind.log

clean:
	rm -fR $(OBJS)
