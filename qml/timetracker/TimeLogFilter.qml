import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

GridLayout {
    id: controlsLayout

    property var beginDate: fromField.selectedDate
    property var endDate: new Date(toField.selectedDate.valueOf() + 86399000)
    property string category
    property bool withCategory: true

    columns: 2
    columnSpacing: 10
    rowSpacing: 10

    Label {
        text: "From:"
    }

    DatePicker {
        id: fromField

        minimumDate: new Date(0)
        maximumDate: toField.selectedDate
    }

    Label {
        text: "To:"
    }

    DatePicker {
        id: toField

        minimumDate: fromField.selectedDate
        maximumDate: new Date()
    }

    Label {
        text: "Category:"
        visible: withCategory
    }

    ComboBox {
        id: categoryField

        model: [ "" ].concat(TimeLog.categories)
        visible: withCategory

        onCurrentTextChanged: {
            if (controlsLayout.category !== currentText) {
                controlsLayout.category = currentText
            }
        }
    }

    onCategoryChanged: {
        if (categoryField.currentText !== category) {
            categoryField.currentIndex = categoryField.find(category)
        }
    }
}
