package parser;

import java_cup.runtime.Symbol;

public class LEXSymbol extends Symbol
{
	protected String my_text;

	public LEXSymbol(int typeId, int lineNumber, int columnNumber, String textValue)
	{
		super(typeId, lineNumber, columnNumber);
		my_text = textValue;
	}

	public LEXSymbol(int typeId, int lineNumber, int columnNumber, Object objectValue, String textValue)
	{
		super(typeId, lineNumber, columnNumber, objectValue);
		my_text = textValue;
	}

	public String toString()
	{
		return "'" + my_text + "'";
	}
}
