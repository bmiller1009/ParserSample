//----------------------------------------------------
// The following class is used to pinpoint locations 
// inside a source file
//----------------------------------------------------

package parser;

public class SrcLoc
{
	private int source_line;
	private int source_col;

	private String source_file;

	public SrcLoc(int lineNumber, int columnNumber, String fileName)
	{
		source_line = lineNumber;
		source_col = columnNumber;
		source_file = fileName;
	}

	public String toString()
	{
		return source_file + ":" + source_line + ":" + source_col;
	}
}
