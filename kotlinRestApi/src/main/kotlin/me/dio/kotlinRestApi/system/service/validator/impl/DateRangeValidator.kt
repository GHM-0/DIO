import java.time.LocalDate
import java.time.temporal.ChronoUnit

class DateValidator {
    fun isValidDateRange(date: LocalDate, annotation: ValidDateRange): Boolean {
        val now = LocalDate.now()
        val futureDate = now.plus(annotation.value.toLong(), ChronoUnit.valueOf(annotation.unit))
        return date.isAfter(now)  && date.isBefore(futureDate)
    }
}
