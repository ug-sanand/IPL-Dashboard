import { LightningElement } from 'lwc';
import fetchCricketData from '@salesforce/apex/IPLController.fetchCricketData';

export default class IplBanner extends LightningElement {
    @Wire(fetchCricketData)
}