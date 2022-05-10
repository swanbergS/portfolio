################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/GamePhrases.cpp \
../src/GameState.cpp \
../src/homework1.cpp 

OBJS += \
./src/GamePhrases.o \
./src/GameState.o \
./src/homework1.o 

CPP_DEPS += \
./src/GamePhrases.d \
./src/GameState.d \
./src/homework1.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


