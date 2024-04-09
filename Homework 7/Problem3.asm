.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

INCLUDE Irvine32.inc

.DATA
	Sensor1		SWORD ?
	Sensor2		SWORD ?
	prompt1		BYTE "Enter a reading for Sensor 1: ",0
	prompt2		BYTE "Enter a reading for sensor 2: ",0
	max			SWORD 70
	min			SWORD -70
	nose		SWORD 50
	errorMsg	BYTE "Input data out of Bounds (-70,70)", 0
	agreeMsg	BYTE "Agree",0
	disagreeMsg	BYTE "Disagree",0
	noseDownMsg BYTE "Nose Down",0

.code

	main proc
		call Sensor1data
		call Sensor2data
		call SensorCompare
		invoke Exitprocess, 0

		exit
	main endp

	Sensor1data proc
		mov edx, OFFSET prompt1		;Prompt, fill, and check Sensor1 data
		call WriteString
		call ReadInt
		mov Sensor1, ax
		movsx eax, Sensor1
		movsx edx, max
		cmp eax, edx
		jg OutOfBounds
		movsx edx, min
		cmp eax, edx
		jl OutOfBounds

		jmp Done

	OutOfBounds:
		mov edx, OFFSET errorMsg
		call WriteString
		invoke ExitProcess, 0

	Done:
	Sensor1data endp

	Sensor2data proc				;Prompt, fill, and check Sensor2 data
		mov eax, 0
		mov edx, OFFSET prompt2
		call WriteString
		call ReadInt
		mov Sensor2, ax
		movsx eax, Sensor2
		movsx edx, max
		cmp eax, edx
		jg OutOfBounds
		movsx edx, min
		cmp eax, edx
		jl OutOfBounds

		jmp Done

	OutOfBounds:					;If the input data is out of bounds, prints errorMsg
		mov edx, OFFSET errorMsg	;and exits
		call WriteString
		invoke ExitProcess, 0

	Done:
	Sensor2data endp

	SensorCompare Proc
		movsx eax, Sensor1
		movsx ebx, Sensor2
		sub eax, ebx
		jns Difference
		neg eax
		jns Difference

	Difference:						;checks to see if the difference is within 4
		cmp eax, 4
		jg disagree					;Absolute difference is greater than 4, so disagree
		jmp Within4Units

	Within4Units:					;Checks if NoseDown applies
		movsx eax, Sensor1
		movsx ebx, nose
		cmp eax, ebx
		jl agree
		jmp NoseDown

	disagree:						;prints "Disagree"
		mov edx, OFFSET disagreeMsg
		call WriteString
		call Crlf
		invoke ExitProcess, 0

	NoseDown:						;Prints "Nose Down"
		;mov edx, OFFSET agreeMsg	- Add these lines to include Agree        
		;call WriteString
		;call Crlf
		mov edx, OFFSET noseDownMsg	;Additional instructions included
		call WriteString
		call Crlf
		invoke ExitProcess, 0

		;If you want NoseDown: to also print agree, add the commented lines

		;these additional lines would allow for "Agree" and "Nose Down" to
		;be printed on seperate lines.
		;The Instructions were unclear, so I am including this just in case

	agree:
		mov edx, OFFSET agreeMsg
		call WriteString
		call Crlf
		Invoke ExitProcess, 0

	Done:
		Invoke ExitProcess, 0

	SensorCompare endp
	
end main
