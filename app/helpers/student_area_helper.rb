module StudentAreaHelper
	
  def student_area_date(data)
    # formatting date: Aug, 31 2007 - 9:55PM
    data.strftime(" %b, %m %Y ")
  end

end
