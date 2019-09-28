module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def getClass(fieldName)
    field = params[:field]
    if field == fieldName
      return 'hilite'
    else
      return 'bg-warning'
    end
  end
  
  def isChecked(rating)
    if params[:ratings] == nil
      return true
    end

    if params[:ratings].include?(rating)
      return true
    else
      return false
    end
    
  end
end
