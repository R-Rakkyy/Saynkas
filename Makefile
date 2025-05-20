# No Wildcards
NAME	= 				Solomon
VERSION = 				1.0

RM = 					rm -f

C++  ?= 				c++

FLAGS = 				-Wall -Wextra -Werror -MMD -MP -std=c++98

# Directories

MAIN_DIR = ${NAME}_v${VERSION}
INCLUDE_DIR = ${MAIN_DIR}/include/
LIB_DIR = ${MAIN_DIR}/libs/
SRC_DIR = ${MAIN_DIR}/src/
OBJ_DIR = ${MAIN_DIR}/obj/

CXXFLAGS = ${FLAGS} -I${INCLUDE_DIR}
LDFLAGS = #-L${OBJ_DIR} -l${NAME}
SRCS = ${SRC_DIR}main.cpp
OBJS = $(patsubst ${SRC_DIR}%.cpp, ${OBJ_DIR}%.o, $(SRCS))
DEPS = $(patsubst ${SRC_DIR}%.cpp, ${OBJ_DIR}%.d, $(SRCS))

# Libraries
LIBS = -lm

# Colors

COLOR_SUCCESS = \033[1;32m
COLOR_INFO = \033[0;33m
NO_COLOR = \033[0m

# Targets

all: ${NAME}
		@echo "${COLOR_SUCCESS}Build complete!${NO_COLOR}"
		@echo "${COLOR_INFO}Executable: ${NAME}${NO_COLOR}"
		@echo "${COLOR_INFO}Version: ${VERSION}${NO_COLOR}"
		@echo "${COLOR_INFO}===============================${NO_COLOR}"

${NAME}: ${OBJS}
	mkdir -p ${OBJ_DIR}
	mkdir -p ${LIB_DIR}
	mkdir -p ${INCLUDE_DIR}
	${C++} ${CXXFLAGS} -o $@ $^ ${LDFLAGS} ${LIBS}
	echo "${COLOR_SUCCESS}Linking complete!${NO_COLOR}"

${OBJ_DIR}%.o: ${SRC_DIR}%.cpp
	mkdir -p ${OBJ_DIR}
	${C++} ${CXXFLAGS} -c $< -o $@
	@echo "${COLOR_SUCCESS}Compiling $< to $@${NO_COLOR}"
	@echo "${COLOR_INFO}===============================${NO_COLOR}"
	@echo "${COLOR_INFO}Compiling $@${NO_COLOR}"


# Clean up
clean:
	@echo "${COLOR_INFO}Cleaning up...${NO_COLOR}"
	$(RM) ${OBJS}
	$(RM) ${DEPS}
	@echo "${COLOR_SUCCESS}Clean complete!${NO_COLOR}"
	@echo "${COLOR_INFO}===============================${NO_COLOR}"
	
fclean:
	@echo "${COLOR_INFO}Force cleaning up...${NO_COLOR}"
	$(RM) ${OBJS}
	$(RM) ${DEPS}
	$(RM) ${NAME}
	@echo "${COLOR_SUCCESS}Force clean complete!${NO_COLOR}"
	@echo "${COLOR_INFO}===============================${NO_COLOR}"

re: fclean all
	@echo "${COLOR_SUCCESS}Rebuild complete!${NO_COLOR}"
	@echo "${COLOR_INFO}===============================${NO_COLOR}"
	
.PHONY: all clean fclean re
.SECONDARY: ${OBJS} ${DEPS}
-include ${DEPS}

		