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
public class ConstantExpression implements Expression{

	private Value mValue;
	
	public ConstantExpression(Value zValue) {
		mValue = zValue;
	}
	
	@Override
	public Value getValue(Contract zContract) throws ExecutionException {
		return mValue;
	}
	
	@Override
	public String toString() {
		return mValue.toString();
	}
}
