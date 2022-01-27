/**
 * 
 */
package global.org.minima.kissvm.expressions;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.values.Value;

/**
 * @author Spartacus Rex
 *
 */
public class VariableExpression implements Expression {

	String mVariableName;
	
	public VariableExpression(String zName) {
		super();
		
		//Store the name
		mVariableName = zName;
	}

	@Override
	public Value getValue(Contract zContract) throws ExecutionException {
		//Get the Value.. 
		Value val = zContract.getVariable(mVariableName);
		
		if(val == null) {
			throw new ExecutionException("Variable does not exist : "+mVariableName);
		}
		
		return val;
	}
	
	@Override
	public String toString() {
		return "variable:"+mVariableName;
	}
}


