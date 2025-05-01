return {
	["pr"] = 'println!("${1:string}");',
	["pra"] = 'printf("${1:string}", ${2:args});',
	["open"] = "let mut f = std::fs::read_to_string(${1:file})?;",
	["for"] = "for ${1:x} in ${2:1..100} {\n\t${3:body}\n}",
	["while"] = "while ${1:condition} {\n\t${2:body}\n}",
	["fn"] = "fn ${1:name}(${2:args}) -> ${3:return_type}{\n\t${4:body}\n}",
}
