return {
	["pr"] = 'printf("${1:string}\n");',
	["pra"] = 'printf("${1:string}\n", ${2:args});',
	["open"] = 'FILE *fptr;\nchar mystring[100];\n\nfptr = fopen("{1:filename}", "r");\nfgets(mystring, 100, fptr);',
	["for"] = "for(${1:int i};${2:limit};${3:i++}){\n\t${4:body}\n}",
	["while"] = "while(${1:limit}){\n\t${2:body}\n}",
	["fn"] = "${1:return_type} ${2:name}(${3:args}){\n\t${4:body}\n}",
}
