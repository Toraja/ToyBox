# param([string] $type, [string] $name)
$option = $args[0]

If ($option -eq "-f"){
	If ($args.count -ne 2){
		echo "-f option requires file path as a parameter"
		exit
	}
	$count = 0
	$filePath = $args[1]
	foreach($i in cat $filePath){
		$temp = $i -split " "
		If ($temp.count -ne 2){
			$count = $count + 1
			echo "Invalid param. Check the line $count of the input file"
			exit
		}
		$type = $temp[0]
		$name = $temp[1]
		
		$capName = (C:\Users\Takanori\ToyBox\PS1\toUpperCase.ps1 $name)
		
		echo @"
public void set$capName($type $name){
    this.$name = $name;
}
public $type get$capName(){
    return this.$name;
}

"@
	}
}
ElseIf ($option -eq "-s"){
	If ($args.count -ne 3){
		echo "-s option requires type and name of variables as parameters"
		exit
	}
	$type = $args[1]
	$name = $args[2]

	$capName = (C:\Users\Takanori\ToyBox\PS1\toUpperCase.ps1 $name)

	echo @"
public void set$capName($type $name){
    this.$name = $name;
}
public $type get$capName(){
    return this.$name;
}

"@
}	
Else {
	echo "Invalid option. -f for file input, -s for direct input."
}