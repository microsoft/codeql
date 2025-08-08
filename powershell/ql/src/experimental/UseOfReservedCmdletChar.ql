/**
 * @name Reserved Characters in Function Name
 * @description Do not use reserved characters in function names
 * @kind problem
 * @problem.severity error
 * @security-severity 7.0
 * @precision high
 * @id powershell/microsoft/public/reserved-characters-in-function-name
 * @tags correctness
 *       security
 */

 import powershell

class ReservedCharacter extends string {
    ReservedCharacter() { 
        this = [
        "!", "@", "#", "$",
        "&", "*", "(", ")", 
        "+", "=", "{", "^", 
        "}", "[", "]", "|", 
        ";", ":", "'", "\"", 
        "<", ">", ",", "?", 
        "/", "~"]
    }
}

from Function f, ReservedCharacter r
where f.getLowerCaseName().matches("%"+ r + "%")
select f, "Function name contains a reserved character: " + r