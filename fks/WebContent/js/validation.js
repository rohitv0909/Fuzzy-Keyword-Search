function checkEmpty(data) 
{
	if (data.length == 0)
		return false
	else
		return true
}

function checkLength(data) 
{
	if (data.length<8 )
		return false
	else
		return true
}

function checkPhone(data) 
{
	if (data.length==10)
		return true
	else
		return false
}
