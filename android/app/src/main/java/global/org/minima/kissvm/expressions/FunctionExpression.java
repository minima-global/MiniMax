/**
 * 
 */
package global.org.minima.kissvm.expressions;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.functions.MinimaFunction;
import global.org.minima.kissvm.values.Value;

/**
 * @author Spartacus Rex
 *
 */
public class FunctionExpression implements Expression {
	
	MinimaFunction mFunction;
	
	/**
	 * Create the Function Expression 
	 */
	public FunctionExpression(MinimaFunction zFunction) {
		//Store for later
		mFunction = zFunction;
	}
	
	@Override
	public Value getValue(Contract zContract) throws ExecutionException {
		//Get the Value
		Value val = mFunction.runFunction(zContract);
		
		//This action counts as one instruction
		zContract.incrementInstructions();
				
		//And trace it..
		zContract.traceLog(toString()+" returns:"+val.toString());
		
		return val;
	}
	
	@Override
	public String toString() {
		return "function:"+mFunction.getName()+", params:"+mFunction.getAllParameters();
	}
}
