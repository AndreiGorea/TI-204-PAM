import android.app.DatePickerDialog
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.DatePicker
import android.widget.TextView
import android.widget.Toast
import com.malkinfo.agecalculator.R
import java.util.*

class MainActivity : AppCompatActivity() {
    private lateinit var selectDate:TextView
    private lateinit var calcBtn:Button
    private lateinit var showAge:TextView
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        /**setare find Id*/
        selectDate = findViewById(R.id.selectDate)
        calcBtn = findViewById(R.id.calsi)
        showAge = findViewById(R.id.showAge)

    }

    fun selectDate(view: View) {
        var c = Calendar.getInstance()
        var cDay = c.get(Calendar.DAY_OF_MONTH)
        var cMonth = c.get(Calendar.MONTH)
        var cYear = c.get(Calendar.YEAR)
        /**setare CalendarDialog*/
        val calendarDialog = DatePickerDialog(this,
            DatePickerDialog.OnDateSetListener {
                    view, year, month, dayOfMonth ->
                cDay = dayOfMonth
                cMonth = month
                cYear = year
                calcBtn.visibility = View.VISIBLE
                textMassge("Selectati data nasterii : $cDay/${cMonth}/$cYear")
                calcBtn.setOnClickListener {
                    val currentYear = Calendar.getInstance()
                        .get(Calendar.YEAR)
                   if (cYear>currentYear){
                       textMassge("Data nu este valida")
                   }
                    else{
                       val age = currentYear - cYear
                       showAge.visibility = View.VISIBLE
                       showAge.text = "Varsta dvs este $age ani!"
                       textMassge("Varsta dvs este $age ani!")
                   }
                }
                selectDate.text = "Ati selectat data : $cDay/${cMonth}/$cYear"
            },cYear,cMonth,cDay)
        calendarDialog.show()

    }

    private fun textMassge(s: String) {
           Toast.makeText(this,s,Toast.LENGTH_SHORT).show()
    }



}