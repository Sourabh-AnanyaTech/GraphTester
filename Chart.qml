/*!
 * Elypson's Chart.qml adaptor to Chart.js
 * (c) 2020 ChartJs2QML contributors (starting with Elypson, Michael A. Voelkel, https://github.com/Elypson)
 * Released under the MIT License
 *
 * Updated for Qt6.5 by Sourabh S Nath
 */

import QtQuick
import QtQuick.Controls
import "Chart.js" as Chart

Canvas {
    id: root
    antialiasing: true

    property var jsChart: undefined
    property string chartType: "bar" // Default chart type
    property var chartData
    property var chartOptions
    property double chartAnimationProgress: 0.1
    property real animationEasingType: Easing.InOutExpo
    property int animationDuration: 500
    property var memorizedContext
    property var memorizedData
    property var memorizedOptions
    property alias animationRunning: chartAnimator.running

    signal animationFinished()

    width: 400
    height: 300

    function animateToNewData() {
        chartAnimationProgress = 0.1;
        jsChart.update();
        chartAnimator.restart();
    }

    MouseArea {
        id: eventHandler
        anchors.fill: parent
        hoverEnabled: true
        enabled: true

        property var handler: undefined

        function submitEvent(type, mouse = {}) {
            const mouseEvent = {
                left: 0,
                top: 0,
                x: mouse.x || 0,
                y: mouse.y || 0,
                clientX: mouse.x || 0,
                clientY: mouse.y || 0,
                type: type,
                target: root
            };

            if (handler) {
                handler(mouseEvent);
            }
            root.requestPaint();
        }

        onClicked: (mouse) => submitEvent("click", mouse)
        onPositionChanged: (mouse) => submitEvent("mousemove", mouse)
        onExited: () => submitEvent("mouseout")
        onEntered: () => submitEvent("mouseenter")
        onPressed: (mouse) => submitEvent("mousedown", mouse)
        onReleased: (mouse) => submitEvent("mouseup", mouse)
    }

    PropertyAnimation {
        id: chartAnimator
        target: root
        property: "chartAnimationProgress"
        alwaysRunToEnd: true
        to: 1
        duration: root.animationDuration
        easing.type: root.animationEasingType

        onFinished: root.animationFinished()
    }

    onChartAnimationProgressChanged: root.requestPaint()

    onPaint: {
        const ctx = getContext("2d");

        if (!ctx) return;

        // Ensure the chart is reinitialized if needed
        if (memorizedContext !== ctx || memorizedData !== chartData || memorizedOptions !== chartOptions) {
            jsChart = new Chart.build(ctx, {
                type: chartType,
                data: chartData,
                options: chartOptions
            });

            memorizedContext = ctx;
            memorizedData = chartData;
            memorizedOptions = chartOptions;

            // Bind Chart.js events to QML's MouseArea event handler
            jsChart.bindEvents(function (newHandler) {
                eventHandler.handler = newHandler;
            });

            chartAnimator.start();
        }

        // Clear the canvas before drawing
        ctx.clearRect(0, 0, width, height);
        jsChart.draw(chartAnimationProgress);
    }

    onWidthChanged: if (jsChart) jsChart.resize()
    onHeightChanged: if (jsChart) jsChart.resize()
}
