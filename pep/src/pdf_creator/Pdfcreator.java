package pdf_creator;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;



public class Pdfcreator {
	private int platz=3;
public void createteilnehmerliste(List<String> gruppenteilnehmer,String desc ,String gruppenname, String speicherort)
{OutputStream out;
	try {
		out = new FileOutputStream(new File(speicherort+File.separator+gruppenname+".pdf"));
	
	Document document = new Document(PageSize.A4);
	PdfWriter.getInstance(document, out);
    document.open();
    addMetaData(document, gruppenname);
	Paragraph preface = new Paragraph();
	preface.setFont(new Font(Font.FontFamily.TIMES_ROMAN,18, Font.NORMAL));
	
	preface.setAlignment(Element.ALIGN_CENTER);
	document.newPage();
    try {
		document.add(new Chunk(""));
	} catch (DocumentException e) {
		
	}
	preface.add("Gruppe: "+gruppenname);
	document.add(preface);
	document.add(Chunk.NEWLINE);
	preface.clear();
	document.add(preface);
	document.add(Chunk.NEWLINE);
	preface.clear();
	preface.add("Projektbeschreibung: "+desc);
	document.add(preface);
	document.add(Chunk.NEWLINE);
	preface.clear();
	document.add(preface);
	document.add(Chunk.NEWLINE);
	preface.clear();
	for(int i=0;i<gruppenteilnehmer.size();i++)
	{
	preface.setFont(new Font(Font.FontFamily.TIMES_ROMAN,12, Font.NORMAL));
	preface.setAlignment(Element.ALIGN_LEFT);
	preface.add(gruppenteilnehmer.get(i)+": _________________________________");
	document.add(preface);
	document.add(Chunk.NEWLINE);
	preface.clear();
	}
	document.add(preface);
	document.add(Chunk.NEWLINE);
	preface.clear();
	preface.add("Dieses Formular muss von jedem Gruppenmitglied unterschrieben werden und dann an den zugehörigen Lehrstuhl abgegebenwerden.");
	document.add(preface);
	document.add(Chunk.NEWLINE);
	preface.clear();
	document.close();
	out.close();
    
	} catch (DocumentException | IOException e) {
	
	}
	
}

private void addMetaData(Document document, String name)
{
	document.addTitle(name);
    document.addSubject("PEP");
    document.addKeywords("");
    document.addAuthor("");
    document.addCreator("");
}

public void createabschlusspraesentation(String speicherort,List<Gruppe>gruppen, String hin) {
	int lastelem=0;
	platz=3;
	try {
		OutputStream out = new FileOutputStream(new File(hin+File.separator+"abschlusspraesentation.pdf"));
		Document document = new Document(PageSize.A4.rotate());
		PdfWriter writer = PdfWriter.getInstance(document, out);
        document.open();
        addMetaData(document);
        GetData inhalt=new GetData(speicherort);
        inhalt.readLines();
        Paragraph preface = new Paragraph();
        preface.setFont(new Font(Font.FontFamily.TIMES_ROMAN,18, Font.NORMAL));
     	preface.setAlignment(Element.ALIGN_CENTER);
     	preface.setLeading(0, 1);
     	String schreib;
     	document.newPage();
		document.add(new Chunk(""));
        for(;inhalt.getLine()!=null;inhalt.readLines())
        {
        	schreib=inhalt.getLine();
        	
    		for(int metadatabeginn=schreib.indexOf("<");metadatabeginn>=0;metadatabeginn=schreib.indexOf("<"))
     	    {
     	    String write=schreib.substring(0, metadatabeginn);
     	    preface.add(write);   	    
     	    int metadataend=schreib.indexOf(">");
     	    String metadata=schreib.substring(metadatabeginn,metadataend+1);
     	    schreib=schreib.substring(metadataend+1);
        	    String notmetadata=metadata;
     	    metadataend=metadata.indexOf(" ");
     	    if(metadataend<=-1)
     	    metadataend=metadata.length();
     	    else
     	    metadataend++;
     	    metadata=metadata.substring(1, metadataend-1);
     	    switch(metadata)
     	    {
     	    	case "f":preface.setFont(inhalt.addmod(0));break;
     	    	case "k":preface.setFont(inhalt.addmod(1));break;
     	    	case "u":preface.setFont(inhalt.addmod(2));break;
     	    	case "left":preface.setAlignment(Element.ALIGN_LEFT);break;
     	    	case "middle":preface.setAlignment(Element.ALIGN_CENTER);break;
     	    	case "right":preface.setAlignment(Element.ALIGN_RIGHT);break;
     	    	case "color": int ok[]=rgb(notmetadata); if(ok[0]<0)preface.add(notmetadata); else {preface.setFont(inhalt.recolor(ok[0], ok[1], ok[2]));}break;
     	    	case "size": int oksize =resize(notmetadata); if(oksize<1)preface.add(notmetadata); else {inhalt.resize(oksize);preface.setFont(inhalt.getFont());}break;
     	    	case "/f":preface.setFont(inhalt.removemod(0));break;
     	    	case "/k":preface.setFont(inhalt.removemod(1));break;
     	    	case "/u":preface.setFont(inhalt.removemod(2));break;
     	    	case "spacing":float space=newspace(notmetadata);if(space<-0.5)preface.add(notmetadata); else {preface.setLeading(0, space);}
     	    	case "newPage": document.newPage();  		document.add(new Chunk("")); break;
     	    	case "gruppenansage":List<String>a=new ArrayList<String>();
     	    	for(int k=schreib.indexOf("</gruppenansage>");k==-1;k=schreib.indexOf("</gruppenansage>"))
     	    	{
     	    		a.add(schreib);
     	    		inhalt.readLines();
     	    		schreib=inhalt.getLine();
     	    	}
     	    	a.add(schreib.substring(0, schreib.indexOf("</gruppenansage>")));
     	    	
     	    	lastelem=gruppenansage(document, a,gruppen,lastelem,inhalt.getFont(),inhalt);
     	    	schreib=schreib.substring(schreib.indexOf("</gruppenansage>")+16);
     	    	break;
     	    	
     	    	default:preface.add(notmetadata);break;
     	    }
     	    }
     	    
     	    	 preface.add(schreib);
     	    	 document.add(preface);
     	    	 preface.clear();
     	    
     	        
     	    }//ende der for schleife
  
        //alle elemente durchgegeangen
        document.close();
        out.flush();
        out.close();
        
		
				} catch (Exception e) {
					e.printStackTrace();
				     }
	
			}

private int gruppenansage(Document document, List<String> a, List<Gruppe> gruppen, int lastelem, Font font, GetData inhalt) {
	try {	
     	for(int l=lastelem;l<gruppen.size()&&gruppen.get(l).getPlatz()==platz&&platz>0;l++) { 
   		int k=0;
   		Paragraph preface = new Paragraph();
 	 	preface.setFont(font);
 	 	inhalt.setFont(font);
 	 	//document.newPage();
 	 	for(;k<a.size();k++) {
 		String schreib=a.get(k);
 	    for(int metadatabeginn=schreib.indexOf("<");metadatabeginn>=0;metadatabeginn=schreib.indexOf("<"))
 	    {
 	    
 	    String write=schreib.substring(0, metadatabeginn);
 	    preface.add(write);   	    
 	    int metadataend=schreib.indexOf(">");
 	    String metadata=schreib.substring(metadatabeginn,metadataend+1);
 	    schreib=schreib.substring(metadataend+1);
    	String notmetadata=metadata;
 	    metadataend=metadata.indexOf(" ");
 	    if(metadataend<=-1)
 	    metadataend=metadata.length();
 	    else
 	    metadataend++;
 	    metadata=metadata.substring(1, metadataend-1);
 	    switch(metadata)
 	    {
 	    	case "f":preface.setFont(inhalt.addmod(0));break;
 	    	case "k":preface.setFont(inhalt.addmod(1));break;
 	    	case "u":preface.setFont(inhalt.addmod(2));break;
 	    	case "left":preface.setAlignment(Element.ALIGN_LEFT);break;
 	    	case "middle":preface.setAlignment(Element.ALIGN_CENTER);break;
 	    	case "right":preface.setAlignment(Element.ALIGN_RIGHT);break;
 	    	case "color": int ok[]=rgb(notmetadata); if(ok[0]<0)preface.add(notmetadata); else {preface.setFont(inhalt.recolor(ok[0], ok[1], ok[2]));}break;
 	    	case "size": int oksize =resize(notmetadata); if(oksize<1)preface.add(notmetadata); else {inhalt.resize(oksize);preface.setFont(inhalt.getFont());}break;
 	    	case "/f":preface.setFont(inhalt.removemod(0));break;
 	    	case "/k":preface.setFont(inhalt.removemod(1));break;
 	    	case "/u":preface.setFont(inhalt.removemod(2));break;
 	    	case "spacing":float space=newspace(notmetadata);if(space<-0.5)preface.add(notmetadata); else {preface.setLeading(0, space);}break;
 	    	case "newPage": document.newPage();  		document.add(new Chunk("")); break;
 	    	case "group":preface.add("Gruppe "+gruppen.get(l).getGruppennr());break;
 	    	case "place":switch(gruppen.get(l).getPlatz())
 	    				{
 	    					case 1: preface.add("Erste Platz"); break;
 	    					case 2:preface.add("Zweite Platz");break;
 	    					case 3:preface.add("Dritte Platz");break;
 	    				}break;
 	    	case "name":preface.add( gruppen.get(l).getName());break;
 	    	case "/gruppenansage":k=a.size()+1;break;
 	    	default:preface.add(notmetadata);break;
 	    }
 	   
 	    }//ende des einlesens
 	    preface.add(schreib);	 
 	    document.add(preface);
 	    	 preface.clear();
 	    	document.newPage();
 	    }//alle Linien bekommen
 	 lastelem++; k=0;
   	}//alle gruppen ausgegeben
     //document.newPage();
	}catch (Exception e) {
		e.printStackTrace();
	}
    platz--;
 	return  lastelem;
}

public void creategewinnerliste(int gruppenanzahl,List<Integer> anzahlprogruppe,List<String>gruppenname, String hin)
{
	try {
	OutputStream out = new FileOutputStream(new File(hin+File.separator+"Gewinnerliste.pdf"));
	Document document = new Document(PageSize.A4.rotate());
	PdfWriter writer = PdfWriter.getInstance(document, out);
    document.open();
    Paragraph preface = new Paragraph();
    document.newPage();
    preface.setFont(new Font(Font.FontFamily.TIMES_ROMAN,23, Font.NORMAL));
	preface.setAlignment(Element.ALIGN_MIDDLE);
	preface.setLeading(0, 1);
   	document.add(new Chunk(""));
	preface.add("Gewinnerliste");
	document.add(preface);
	preface.clear();
	document.add(Chunk.NEWLINE);
	document.add(Chunk.NEWLINE);
	preface.setFont(new Font(Font.FontFamily.TIMES_ROMAN,18, Font.NORMAL));
	preface.setAlignment(Element.ALIGN_LEFT);
	preface.setLeading(0, 1);
	int gt=0;
	for(int k=0;k<gruppenanzahl;k++)
	{	
		preface.add("");
		document.add(preface);
		preface.clear();
		k++;
		preface.add("Gruppe: "+k);
		k--;
		document.add(preface);
		preface.clear();
		int platzz=anzahlprogruppe.get(k);
		for(int j=0;j<anzahlprogruppe.get(k);j++)
		{	
			preface.add("                  "+platzz+".Platz: "+gruppenname.get(j+gt));
			document.add(preface);
			preface.clear();
			platzz--;
		}
		document.add(Chunk.NEWLINE);
		gt=gt+anzahlprogruppe.get(k);
	}
	document.close();
	out.close();
	out.flush();
	
	
	} catch (Exception e) {
		
	}
	
    
}
		
private float newspace(String notmetadata) {
	notmetadata=notmetadata.substring(notmetadata.indexOf(" ")+1, notmetadata.length()-1);
	float size = -1;
	try {size=Float.parseFloat(notmetadata);}
	catch (Exception e) {
	  size=-1;    
	     }
	return size;
}

private int resize(String notmetadata) {
	notmetadata=notmetadata.substring(notmetadata.indexOf(" ")+1, notmetadata.length()-1);
	int size = -1;
	try {size=Integer.parseInt(notmetadata);}
	catch (Exception e) {
	  size=-1;    
	     }
	return size;
}

private int[] rgb(String notmetadata) {
	notmetadata=notmetadata.substring(notmetadata.indexOf(" ")+1, notmetadata.length());
	int result[]=new int[3];
	try
	{
		int r,g,b;
		int komma=notmetadata.indexOf(",");
		r=Integer.parseInt(notmetadata.substring(0,komma));
		notmetadata=notmetadata.substring(komma+1);
		komma=notmetadata.indexOf(",");
		g=Integer.parseInt(notmetadata.substring(0,komma));
		notmetadata=notmetadata.substring(komma+1);
		komma=notmetadata.indexOf(">");
		b=Integer.parseInt(notmetadata.substring(0,komma));
		result[0]=r;
		result[1]=g;
		result[2]=b;
		
	}
	catch(Exception e) {
		result[0]=-1;
		     }
	 return result;
	
	
}

private void addMetaData(Document document) {
	document.addTitle("Abschlusspräsentation");
    document.addSubject("PEP");
    document.addKeywords("");
    document.addAuthor("");
    document.addCreator("");}


}