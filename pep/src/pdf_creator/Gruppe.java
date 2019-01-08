package pdf_creator;


public class Gruppe {
	private int gruppennr;
	private int platz;
	private String nam;
	
	public Gruppe(int gruppennrr, int platzz, String name)
	{
		gruppennr=gruppennrr;
		platz=platzz;
		nam=name;
	}
	public int getPlatz()
	{
		return platz;
	}
	public int getGruppennr()
	{
		return gruppennr;
	}
	public String getName()
	{
		return nam;
	}
	
}

