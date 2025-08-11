/**
 * @name Insecure Symmetric cipher mode
 * @description Use of insecure cipher mode
 * @kind problem
 * @problem.severity error
 * @security-severity 8.8
 * @precision high
 * @id powershell/microsoft/public/weak-cipher-mode
 * @tags correctness
 *       security
 *       external/cwe/cwe-327
 */


import powershell
import semmle.code.powershell.dataflow.DataFlow
import semmle.code.powershell.dataflow.TaintTracking
import semmle.code.powershell.ApiGraphs

class AesCreation extends ObjectCreation{
    AesCreation(){
        this.getAnArgument().getValue().asString() = "System.Security.Cryptography.AesManaged"
    }
}

class AesModeProperty extends MemberExpr {
    AesModeProperty(){
        exists(DataFlow::ObjectCreationNode aesObjectCreation, DataFlow::Node aesObjectAccess |
            aesObjectCreation.asExpr().getExpr() instanceof AesCreation and
            aesObjectAccess.getALocalSource() = aesObjectCreation and 
            aesObjectAccess.asExpr().getExpr() = this.getQualifier() and 
            this.getLowerCaseMemberName() = "mode"
        )
        
    }
}

class WeakAesMode extends DataFlow::Node {
    WeakAesMode(){
        exists(API::Node node, string modeValue | 
            node = API::getTopLevelMember("system").getMember("security").getMember("cryptography").getMember("ciphermode").getMember(modeValue) and 
            modeValue = ["ecb", "ofb", "cfb", "ctr"] and 
            this = node.asSource()
        )
    }
}


module Config implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof WeakAesMode }

  predicate isSink(DataFlow::Node sink) { sink.asExpr().getExpr() instanceof AesModeProperty }
  predicate isAdditionalFlowStep(DataFlow::Node nodeFrom, DataFlow::Node nodeTo){
    exists(AssignStmt a | 
        nodeTo.asExpr().getExpr() = a.getLeftHandSide() and 
        nodeFrom.asExpr().getExpr() = a.getRightHandSide()
    )
  }
}

module WeakEncryptionFlow = TaintTracking::Global<Config>; 

from DataFlow::Node source, DataFlow::Node sink
where WeakEncryptionFlow::flow(source, sink)
select source, sink
