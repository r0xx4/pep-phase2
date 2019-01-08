package pdf_creator;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Font;

public class GetData {
	private FileReader fr;
	private BufferedReader br;
	private int alignment;
	private Font font;
	private int schriftgroese;
	private int[] rgb =new int[3];
	private int[] mod=new int[3];
	private String inhalt;
	
	public GetData(String speicherort) throws IOException

	{
		fr = new FileReader(speicherort);
		br = new BufferedReader(fr);
		rgb[0]=0;
		rgb[1]=0;
		rgb[2]=0;
		mod[0]=0;
		mod[1]=0;
		mod[2]=0;
		resize(18);
		alignment=0;
		
	  
	}
	public void readLines() throws IOException
	{
		String ausgabe=br.readLine();
		if(ausgabe==null)
		{
			inhalt= null;		
		}
		else
		{
			inhalt= ausgabe;
		}
	}
	public String getLine()
	{
		return inhalt;
	}
	public Font getFont()
	{
		return font;
		
	}
	public int getAlignment()
	{
		return alignment;
	}
	public void resize(int grose)
	{	
		schriftgroese=grose;
		int modcode=mod[2]*100+mod[1]*10+mod[0];
		switch(modcode)
		{
		case 000:font=new Font(Font.FontFamily.TIMES_ROMAN,grose, Font.NORMAL,new BaseColor(rgb[0],rgb[1],rgb[2]));break;
		case 100:font= new Font(Font.FontFamily.TIMES_ROMAN,grose, Font.UNDERLINE,new BaseColor(rgb[0],rgb[1],rgb[2]));break;
		case 10:font=new Font(Font.FontFamily.TIMES_ROMAN,grose, Font.ITALIC,new BaseColor(rgb[0],rgb[1],rgb[2]));break;
		case 1:font=new Font(Font.FontFamily.TIMES_ROMAN,grose, Font.BOLD,new BaseColor(rgb[0],rgb[1],rgb[2]));break;
		case 110:font= new Font(Font.FontFamily.TIMES_ROMAN,grose, Font.ITALIC|Font.UNDERLINE,new BaseColor(rgb[0],rgb[1],rgb[2]));break;
		case 101:font=new Font(Font.FontFamily.TIMES_ROMAN,grose,Font.BOLD|Font.UNDERLINE,new BaseColor(rgb[0],rgb[1],rgb[2]));break;
		case 11:font = new Font(Font.FontFamily.TIMES_ROMAN,grose, Font.BOLD|Font.ITALIC,new BaseColor(rgb[0],rgb[1],rgb[2]));break;
		case 111:font= new Font(Font.FontFamily.TIMES_ROMAN,grose, Font.ITALIC|Font.UNDERLINE|Font.BOLD,new BaseColor(rgb[0],rgb[1],rgb[2]));break;
		default: font=new Font(Font.FontFamily.TIMES_ROMAN,grose, Font.NORMAL,new BaseColor(0,0,0));break;
		}
		
	}
	public Font addmod(int modnr)
	{
		if(mod[modnr]==0)
			{mod[modnr]=1;
			resize(schriftgroese);
			}
		return font;
	}
	public Font removemod(int modnr)
	{
		if(mod[modnr]==1)
		{mod[modnr]=0;
		resize(schriftgroese);
		}
		return font;
	}
	public Font recolor(int r, int g, int b)
	{
		rgb[0]=r;
		rgb[1]=g;
		rgb[2]=b;
		resize(schriftgroese);
		return font;
	}

	public void setFont(Font f)
	{
		font=f;
	}
}

