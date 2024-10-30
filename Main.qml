import QtQuick
import "Chart.js" as Chart

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    id: theWindow


    function randomScalingFactor() {
        return Math.random().toFixed(1);
    }


    Rectangle {
        id: grid
        anchors.fill: parent
        Chart {
            height: 400
            width: 500
            chartType: 'scatter'
            chartData: {
                return {
                    datasets: [{
                            label: 'My First dataset',
                            xAxisID: 'x-axis-1',
                            yAxisID: 'y-axis-1',
                            borderColor: '#ff5555',
                            backgroundColor: 'rgba(255,192,192,0.3)',
                            data: [{
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }]
                        }, {
                            label: 'My Second dataset',
                            xAxisID: 'x-axis-1',
                            yAxisID: 'y-axis-2',
                            borderColor: '#5555ff',
                            backgroundColor: 'rgba(192,192,255,0.3)',
                            data: [{
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }, {
                                    x: theWindow.randomScalingFactor(),
                                    y: theWindow.randomScalingFactor(),
                                }]
                        }]
                }}
            chartOptions: {return {
                    maintainAspectRatio: false,
                    responsive: true,
                    hoverMode: 'nearest',
                    intersect: true,
                    title: {
                        display: true,
                        text: 'Chart.js Scatter Chart - Multi Axis'
                    },
                    scales: {
                        xAxes: [{
                                position: 'bottom',
                                gridLines: {
                                    zeroLineColor: 'rgba(0,0,0,1)'
                                }
                            }],
                        yAxes: [{
                                type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                display: true,
                                position: 'left',
                                id: 'y-axis-1',
                            }, {
                                type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                display: true,
                                position: 'right',
                                reverse: true,
                                id: 'y-axis-2',

                                // grid line settings
                                gridLines: {
                                    drawOnChartArea: false, // only want the grid lines for one axis to show up
                                },
                            }],
                    }
                }
            }

            anchors {
                left: parent.left
                top: parent.top
            }
        }
    }
}
