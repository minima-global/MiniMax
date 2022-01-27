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
public interface Expression {
	public Value getValue(Contract zContract) throws ExecutionException;
}
