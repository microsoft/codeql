import cpp
import semmle.code.cpp.models.implementations.Strcat
import semmle.code.cpp.models.interfaces.FormattingFunction

class StrConcatenation extends Call{
    StrConcatenation(){
        exists(FormattingFunctionCall fc | 
            this = fc
          )
        or
        exists(StrcatFunction f | this.getTarget() = f) or
        exists(Call call, Operator op |
            call.getTarget() = op and
            op.hasQualifiedName(["std", "bsl"], "operator+") and
            op.getType().(UserType).hasQualifiedName(["std", "bsl"], "basic_string") and
            this = call
        ) or
        this.getTarget().hasQualifiedName(["std", "bsl"], "operator<<")
    }

    /**
     * Gets the operands of this concatenation. 
     * Will not return out param for sprintf-like functions, but will consider the format string 
     * to be part of the operands. 
     */
    Expr getAnOperand(){
        result = this.getAnArgument()
        and not result instanceof Call // I believe this addresses odd behavior with overloaded operators
        and 
        (
            result.getUnderlyingType().stripType().getName() = "char"
            or
            result.getUnderlyingType().getName() = "string"
            or
            result.getType().getUnspecifiedType().(UserType).hasQualifiedName(["std", "bsl"], "basic_string")
        )
        and
        (this instanceof FormattingFunctionCall implies 
            (
                result = this.(FormattingFunctionCall).getFormat() or 
                exists(int n | result = this.getArgument(n) and 
                    n >= this.(FormattingFunctionCall).getTarget().(FormattingFunction).getFirstFormatArgumentIndex())
            )
        )
    }

    Expr getResultExpr(){
        if this instanceof FormattingFunctionCall
        then
            result = this.(FormattingFunctionCall).getOutputArgument(_)
        else
            result = this.(Call)
    }
}