$(function() {
    $('#ContentPlaceHolder1_birthday').daterangepicker({
        singleDatePicker: true,
        autoUpdateInput: false,
        showDropdowns: true,
        locale: {
            cancelLabel: 'Clear'
        }
    });
    $('#ContentPlaceHolder1_birthday').on('apply.daterangepicker', function (ev, picker) {
        $(this).val(picker.startDate.format('YYYY-MM-DD'));
    });
});