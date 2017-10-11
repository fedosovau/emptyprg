EXE=test

SRC_DIR=src
OBJ_DIR=obj

SRC= $(wildcard $(SRC_DIR)/*.c)
OBJ= $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
BIN_OBJ=$(OBJ_DIR)/$(EXE).o

CPPFLAGS += -Iinclude
CFLAGS += -Wall
LDFLAGS += -Llib
LDLIBS += -lm

.PHONY: all clean

all: $(EXE)

$(EXE): $(OBJ) $(BIN_OBJ)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(BIN_OBJ): $(EXE).c 
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

clean:
	$(RM) $(OBJ) $(BIN_OBJ) $(EXE)
